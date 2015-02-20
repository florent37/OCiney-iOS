//
//  HeaderMovieDetail.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "HeaderMovieDetail.h"
#import "UIImageView+WebCache.h"
#import "Color+Hex.h"
#import "Constantes.h"

#define SMALL_DURATION 0.4

@implementation HeaderMovieDetail

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 
 */

- (void)drawRect:(CGRect)rect {
    
    self.backgroundColor = [UIColor clearColor];
    
    self.clipsToBounds = YES;
    
    {
        
        self.gradientViewBlack85 = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.gradientViewBlack85];
        
        self.gradient85 = [CAGradientLayer layer];
        self.gradient85.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorFromHexString:@"#000000d9"] CGColor], nil];
        [self.gradientViewBlack85.layer insertSublayer:self.gradient85 atIndex:0];
        
    }
    
    {
        self.jaquette = [[UIView alloc]initWithFrame:CGRectZero];
        [self.jaquette setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.jaquette];
        
    }
    
    
    {
        self.titreFilm = [[UILabel alloc]initWithFrame:CGRectZero];
        self.titreFilm.textAlignment = NSTextAlignmentLeft;
        [self.titreFilm setTextColor:[UIColor whiteColor]];
        self.titreFilm.font = [UIFont fontWithName:BOLD size:13];
        [self addSubview:self.titreFilm];
        
        
    }
    
    {
        self.styleFilm = [[UILabel alloc]initWithFrame:CGRectZero];
        self.styleFilm.textAlignment = NSTextAlignmentLeft;
        [self.styleFilm setTextColor:[UIColor colorFromHexString:WHITE80]];
        self.styleFilm.font = [UIFont fontWithName:LIGHT_ITALIC size:11];
        [self addSubview:self.styleFilm];
    }
    
    {
        self.heureFilm = [[UILabel alloc]initWithFrame:CGRectZero];
        self.heureFilm.textAlignment = NSTextAlignmentLeft;
        [self.heureFilm setTextColor:[UIColor colorFromHexString:GRIS_CLAIRE]];
        self.heureFilm.font = [UIFont fontWithName:BOLD size:11];
        [self addSubview:self.heureFilm];
    }
    
    
    {
        self.imageJaquette = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.jaquette addSubview:self.imageJaquette];
    }
    
    {
        
        self.starRating = [[EDStarRating alloc]initWithFrame:CGRectZero];
        [self.starRating setBackgroundColor:[UIColor clearColor]];
        
        CGRect rect = CGRectMake(0,0,15,15);
        UIGraphicsBeginImageContext( rect.size );
        [[UIImage imageNamed:@"star_off_small.png"] drawInRect:rect];
        UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData = UIImagePNGRepresentation(picture1);
        
        self.starRating.starImage = [UIImage imageWithData:imageData];
        
        UIGraphicsBeginImageContext(rect.size );
        [[UIImage imageNamed:@"star_on_small.png"] drawInRect:rect];
        UIImage *picture2 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *imageData2 = UIImagePNGRepresentation(picture2);
        
        self.starRating.starHighlightedImage = [UIImage imageWithData:imageData2];
        self.starRating.maxRating = 5.0;
        //self.starRating.delegate = self;
        self.starRating.horizontalMargin = 122;
        self.starRating.editable=NO;
        self.starRating.displayMode=EDStarRatingDisplayAccurate;
        
        
        [self addSubview:self.starRating];
        
    }
    
    {
        self.loader = [[OCLoader alloc]initWithFrame:CGRectZero];
        self.loader.alpha = 0.5;
        [self.loader animer];
        [self addSubview:self.loader];
    }
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.imageJaquette action:@selector(onPan:)];
    
}


-(void)chargerAvecMovie:(Movie *)movie{
    self.movie = movie;
    [self setNeedsLayout];
    
    
    //[self remplir];
}

- (void)layoutSubviews{
    
    if(self.movie != nil){
        
        self.gradientViewBlack85.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width,self.frame.size.height);
        //self.gradientViewBlack85.alpha = 0.9;
        
        self.gradient85.frame = self.gradientViewBlack85.bounds;
        
        self.jaquette.frame = CGRectMake(10,10,80,110);
        
        [self.titreFilm setText:self.movie.title];
        
        //(getObject().getUserRating() + getObject().getPressRating()) / 2
        self.starRating.rating= (self.movie.statistics.userRating + self.movie.statistics.pressRating)/2;
        [self.heureFilm setText:[self.movie getDuree]];
        [self.styleFilm setText:[self.movie getGenres]];
        
        [self.imageJaquette sd_setImageWithURL:[NSURL URLWithString:self.movie.poster.href]];
        
        
        [self.parallaxImage sd_setImageWithURL:[NSURL URLWithString:self.movie.defaultMedia.media.thumbnail.href]];
        
        CALayer *layer = self.jaquette.layer;
        layer.shadowOffset = CGSizeMake(2, 2);
        layer.shadowColor = [[UIColor blackColor] CGColor];
        layer.cornerRadius = 0.2f;
        layer.shadowRadius = 3.0f;
        layer.shadowOpacity = 0.80f;
        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
        
        self.imageJaquette.frame = CGRectMake(0,0,self.jaquette.frame.size.width-4,self.jaquette.frame.size.height-4);
        self.imageJaquette.center = CGPointMake(self.jaquette.frame.size.width/2, self.jaquette.frame.size.height/2);
        
        {
            [self.heureFilm sizeToFit];
            NSInteger height = self.heureFilm.frame.size.height;
            NSInteger x = self.jaquette.frame.origin.x + self.jaquette.frame.size.width +10;
            NSInteger y = self.jaquette.frame.origin.y + self.jaquette.frame.size.height - height;
            NSInteger width = self.frame.size.width - x;
            self.heureFilm.frame = CGRectMake(x,y,width,height);
        }
        
        {
            [self.styleFilm sizeToFit];
            NSInteger height = self.styleFilm.frame.size.height;
            NSInteger x = self.heureFilm.frame.origin.x;
            NSInteger y = self.heureFilm.frame.origin.y - height - 3;
            NSInteger width = self.frame.size.width - x;
            self.styleFilm.frame = CGRectMake(x,y,width,height);
        }
        
        {
            [self.titreFilm sizeToFit];
            NSInteger height = self.titreFilm.frame.size.height;
            NSInteger x = self.heureFilm.frame.origin.x;
            NSInteger y = self.styleFilm.frame.origin.y - height - 3;
            NSInteger width = self.frame.size.width - x;
            self.titreFilm.frame = CGRectMake(x,y,width,height);
            
        }
        
        
        
        {
            NSInteger height = 15;
            NSInteger x = self.jaquette.frame.origin.x + self.jaquette.frame.size.width +10 - 124;
            NSInteger y = self.titreFilm.frame.origin.y - height - 3;
            NSInteger width = self.frame.size.width;
            self.starRating.frame = CGRectMake(x,y,width,height);
        }
        
        {
            
            NSInteger margin = 5;
            
            NSInteger height = 20;
            NSInteger width = 20;
            NSInteger x = self.bounds.size.width - width - margin;
            NSInteger y = margin;
            
            self.loader.frame = CGRectMake(x , y, width, height);
            
        }
    }
}

- (void)onPan:(UIPanGestureRecognizer *)pan
{
    [self.delegate onPanJaquette:pan];
}

-(void)chargerVersionsDisponibles
{
    NSInteger globalX = self.bounds.size.width - 3;
    NSInteger elementHeight = 15;
    NSInteger globalY = self.bounds.size.height - elementHeight - 3;
    NSInteger elementWidth = 15;
    CGFloat alpha = 0;
    
    if([self.movie isVF])
    {
        self.isVF = [[OCHeaderVersionView alloc] initWithImage:@"ic_version_white_vf"];
        self.isVF.alpha = alpha;
        [self addSubview:self.isVF];
        
        NSInteger x = globalX - elementWidth;
        NSInteger y = globalY;
        NSInteger width = elementWidth;
        NSInteger height = elementHeight;
        self.isVF.frame = CGRectMake(x, y, width, height);
        
        globalX = x;
    }
    
    if([self.movie isVO])
    {
        self.isVO = [[OCHeaderVersionView alloc] initWithImage:@"ic_version_white_vo"];
        self.isVO.alpha = alpha;
        [self addSubview:self.isVO];
        
        NSInteger x = globalX - elementWidth;
        NSInteger y = globalY;
        NSInteger width = elementWidth;
        NSInteger height = elementHeight;
        self.isVO.frame = CGRectMake(x, y, width, height);
        
        globalX = x;
    }
    
    if([self.movie is2D])
    {
        self.is2D = [[OCHeaderVersionView alloc] initWithImage:@"ic_version_white_2d"];
        self.is2D.alpha = alpha;
        [self addSubview:self.is2D];
        
        NSInteger x = globalX - elementWidth;
        NSInteger y = globalY;
        NSInteger width = elementWidth;
        NSInteger height = elementHeight;
        self.is2D.frame = CGRectMake(x, y, width, height);
        
        globalX = x;
    }
    
    if([self.movie is3D])
    {
        self.is3D = [[OCHeaderVersionView alloc] initWithImage:@"ic_version_white_3d"];
        self.is3D.alpha = alpha;
        [self addSubview:self.is3D];
        
        NSInteger x = globalX - elementWidth;
        NSInteger y = globalY;
        NSInteger width = elementWidth;
        NSInteger height = elementHeight;
        self.is3D.frame = CGRectMake(x, y, width, height);
        
        globalX = x;
    }
    
    NSInteger translation = 100;
    alpha = 1;
    CGAffineTransform preTransform = CGAffineTransformMakeTranslation(translation, 0);
    
    self.isVF.transform = preTransform;
    self.isVO.transform = preTransform;
    self.is2D.transform = preTransform;
    self.is3D.transform = preTransform;
    
    [self animerIs3D];
}

// BON OK c'est crade

-(void)animerIsVF
{
    if(self.isVF == nil){
    }else{
        [self.isVF tourner:SMALL_DURATION];
        [UIView animateWithDuration:SMALL_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.isVF.transform = CGAffineTransformIdentity;
            self.isVF.alpha = 1;
        } completion:^(BOOL finished) {
            [self.isVF arreterTourner];
        }];
    }
}

-(void)animerIsVO
{
    if(self.isVO == nil){
        [self animerIsVF];
    }else{
        [self.isVO tourner:SMALL_DURATION];
        [UIView animateWithDuration:SMALL_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.isVO.transform = CGAffineTransformIdentity;
            self.isVO.alpha = 1;
        } completion:^(BOOL finished) {
            [self.isVO arreterTourner];
            [self animerIsVF];
        }];
    }
}

-(void)animerIs2D
{
    if(self.is2D == nil){
        [self animerIsVO];
    }else{
        [self.is2D tourner:SMALL_DURATION];
        [UIView animateWithDuration:SMALL_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.is2D.transform = CGAffineTransformIdentity;
            self.is2D.alpha = 1;
        } completion:^(BOOL finished) {
            [self.isVO arreterTourner];
            [self animerIsVO];
        }];
    }
}


-(void)animerIs3D
{
    if(self.is3D == nil){
        [self animerIs2D];
    }else{
        [self.is3D tourner:SMALL_DURATION];
        [UIView animateWithDuration:SMALL_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.is3D.transform = CGAffineTransformIdentity;
            self.is3D.alpha = 1;
        } completion:^(BOOL finished) {
            [self.is3D arreterTourner];
            [self animerIs2D];
        }];
    }
}



@end
