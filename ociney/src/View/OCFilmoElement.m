//
//  OCFilmoElement.m
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCFilmoElement.h"
#import "Constantes.h"
#import "Color+Hex.h"
#import "UIImageView+WebCache.h"

@implementation OCFilmoElement{
    CAGradientLayer* gradientLayer;
    BOOL first;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self creer];
    return self;
}

-(void)sizeToFit
{
    [self remplir];
}

-(void)creer
{
    first = YES;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    
    {
        self.layout = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.layout];
        
        self.layout.layer.masksToBounds = NO;
        self.layout.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        //self.layout.layer.shadowRadius = 10;
        self.layout.layer.shadowOpacity = 0.5;
    }
    
    {
        self.gradient = [[UIView alloc] initWithFrame:CGRectZero];
        self.gradient.layer.cornerRadius = 5.0;
        self.gradient.layer.masksToBounds = YES;
        [self.layout addSubview:self.gradient];
        
        gradientLayer = [CAGradientLayer layer];
        
        
        gradientLayer.colors = @[
                                 (id)[[UIColor colorFromHexString:@"#4f4f4f"] CGColor],
                                 (id)[[UIColor colorFromHexString:@"#777777"] CGColor]
                                 ];
        
        [self.gradient.layer insertSublayer:gradientLayer atIndex:0];
        
        
        self.gradient.alpha = 0.8;
        
    }
    
    { //roulette
        self.background = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.background.image = [UIImage imageNamed:@"ic_drawer_films"];
        self.background.alpha = 0.6;
        [self.gradient addSubview:self.background];
    }
    
    self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    [self.gradient addSubview:self.image];
    
    self.glass = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.glass.image = [UIImage imageNamed:@"filmo_reflet"];
    self.glass.contentMode = UIViewContentModeScaleAspectFill;
    self.glass.alpha = 0.4;
    [self.gradient addSubview:self.glass];
    
    self.titre = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titre.font = [UIFont fontWithName:CONDENSED_BOLD size:7];
    self.titre.textAlignment = NSTextAlignmentRight;
    self.titre.textColor = [UIColor blackColor];
    [self addSubview:self.titre];
    
    self.role = [[UILabel alloc] initWithFrame:CGRectZero];
    self.role.font = [UIFont fontWithName:LIGHT size:8];
    self.role.textAlignment = NSTextAlignmentRight;
    self.role.textColor = [UIColor colorFromHexString:BLACK70];
    [self addSubview:self.role];
    
}

-(void)positioner
{
    if(first){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,
                                FILMO_ELEMENT_WIDTH, FILMO_ELEMENT_HEIGHT);
        
        self.layout.frame = CGRectMake(0, 0, FILMO_ELEMENT_WIDTH - 10, FILMO_ELEMENT_IMAGE_HEIGHT - 10);
        self.layout.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        self.gradient.frame = self.layout.bounds;
        gradientLayer.frame = self.gradient.bounds;
        self.background.frame = CGRectMake(0, 0, 38, 38);
        self.background.center = CGPointMake(self.layout.bounds.size.width/2, self.layout.bounds.size.height/2);
        
        
        self.titre.text = @" ";
        [self.titre sizeToFit];
        self.titre.frame = CGRectMake(self.layout.frame.origin.x, self.layout.frame.origin.y + self.layout.frame.size.height+ 3, self.layout.frame.size.width, self.titre.frame.size.height);
        
        self.role.text = @" ";
        [self.role sizeToFit];
        self.role.frame = CGRectMake(self.layout.frame.origin.x, self.titre.frame.origin.y + self.titre.frame.size.height, self.layout.frame.size.width, self.role.frame.size.height);
        
        self.glass.frame = self.layout.bounds;
        
        self.image.frame = self.layout.bounds;
    }

}

-(void)remplir
{
    
    [self positioner];
    self.hidden = NO;
    
    if(self.more){
        self.image.image = [UIImage imageNamed:@"plus_black"];
        self.image.alpha = 0.2;
        
        self.image.frame = CGRectMake(0, 0, 25, 25);
        self.image.center = CGPointMake(self.layout.frame.size.width/2, self.layout.frame.size.height/2);
        
        self.background.frame = self.layout.bounds;
        gradientLayer.hidden = YES;
        self.glass.hidden = YES;
        
        self.background.image = [UIImage imageNamed:@"plus_dashed_photos_black"];
        self.background.contentMode = UIViewContentModeScaleToFill;
        self.background.alpha = 0.2;
        
    }
    else if(self.participation != nil && self.participation.movie != nil){
        
        self.titre.text = self.participation.movie.title;
        
        self.role.text = self.participation.role;
        
        if(self.participation.movie.poster.href !=nil)
        {
            [self.image sd_setImageWithURL:[NSURL URLWithString:self.participation.movie.poster.href]];
        }
    }
    else
    {
        self.hidden = YES;
    }
    
}

-(void)tap
{
    if(self.delegate != nil){
        if(self.more)
            [self.delegate onMoreMovieClicked];
        else
            [self.delegate onMovieClicked:self.index];
    }
}

@end
