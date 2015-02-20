//
//  OCMovieCell.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 24/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCMovieCell.h"
#import "UIImageView+WebCache.h"
#import "Color+Hex.h"



@implementation OCMovieCell{
    BOOL first;
}

- (void)awakeFromNib {
    
    [super layoutSubviews];
    
    self.content = [UIView new];
    
    first = YES;
    
    {
        
        self.gradientView = [UIView new];
        [self.content addSubview:self.gradientView];
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:@"#c8c8c8ff"] CGColor], (id)[[UIColor colorFromHexString:@"#aaaaaaff"] CGColor], nil];
        [self.gradientView.layer insertSublayer:self.gradient atIndex:0];
        
    }
    
    {
        self.parallaxImage = [UIImageView new];
        [self.content addSubview:self.parallaxImage];
    }
    
    {
        
        self.gradientViewBlack85 = [UIView new];
        [self.content addSubview:self.gradientViewBlack85];
        
        self.gradient85 = [CAGradientLayer layer];
        self.gradient85.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorFromHexString:@"#000000d9"] CGColor], nil];
        [self.gradientViewBlack85.layer insertSublayer:self.gradient85 atIndex:0];
        
    }
    
    {
        self.bottomView = [UIView new];
        [self.bottomView setBackgroundColor:[UIColor whiteColor]];
        [self.content addSubview:self.bottomView];
    }
    
    
    {
        self.note = [UILabel new];
        self.note.textAlignment = NSTextAlignmentLeft;
        [self.note setTextColor:[UIColor whiteColor]];
        self.note.font = [UIFont fontWithName:REGULAR size:11];
        [self.content addSubview:self.note];
    }
    
    {
        self.titreFilm = [UILabel new];
        self.titreFilm.textAlignment = NSTextAlignmentLeft;
        [self.titreFilm setTextColor:[UIColor whiteColor]];
        self.titreFilm.font = [UIFont fontWithName:REGULAR size:16];
        [self.content addSubview:self.titreFilm];
        
        
    }
    
    {
        self.styleFilm = [UILabel new];
        self.styleFilm.textAlignment = NSTextAlignmentLeft;
        [self.styleFilm setTextColor:[UIColor whiteColor]];
        self.styleFilm.font = [UIFont fontWithName:LIGHT_ITALIC size:11];
        [self.content addSubview:self.styleFilm];
    }
    
    {
        self.heureFilm = [UILabel new];
        self.heureFilm.textAlignment = NSTextAlignmentLeft;
        [self.heureFilm setTextColor:[UIColor grayColor]];
        self.heureFilm.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:9];
        [self.bottomView addSubview:self.heureFilm];
    }
    
    
    
    {
        self.jaquette = [UIView new];
        [self.jaquette setBackgroundColor:[UIColor whiteColor]];
        [self.content addSubview:self.jaquette];
        
    }
    
    {
        self.fondJaquette = [UIView new];
        
        self.gradientFondJaquette = [CAGradientLayer layer];
        self.gradientFondJaquette.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:@"#c8c8c8ff"] CGColor], (id)[[UIColor colorFromHexString:@"#aaaaaaff"] CGColor], nil];
        
        [self.fondJaquette.layer insertSublayer:self.gradientFondJaquette atIndex:0];
        
        [self.jaquette addSubview:self.fondJaquette];
        
    }
    
    {
        self.rouletteFilm = [OCLoader loader];
        [self.fondJaquette addSubview:self.rouletteFilm];
        
    }
    
    
    {
        self.imageJaquette = [UIImageView new];
        [self.jaquette addSubview:self.imageJaquette];
    }
    
    
    {
        
        self.starRating = [EDStarRating new];
        [self.starRating setBackgroundColor:[UIColor clearColor]];
        self.starRating.starImage = [UIImage imageNamed:@"star_off_small.png"];
        self.starRating.starHighlightedImage = [UIImage imageNamed:@"star_on_small.png"];
        self.starRating.maxRating = 5.0;
        //self.starRating.delegate = self;
        self.starRating.horizontalMargin = 5;
        self.starRating.editable=NO;
        self.starRating.displayMode=EDStarRatingDisplayAccurate;
        
        
        [self.content addSubview:self.starRating];
        
    }
    
    
    {
        self.enSalle = [UILabel new];
        self.enSalle.textAlignment = NSTextAlignmentLeft;
        [self.enSalle setTextColor:[UIColor colorFromHexString:WHITE90]];
        self.enSalle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
        [self.content addSubview:self.enSalle];
    }
    
    
    {
        self.viewClick = [UIView new];
        [self.viewClick setBackgroundColor:[UIColor clearColor]];
        [self.viewClick addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(onClick:)]];
        
        [self.content addSubview:self.viewClick];
    }
    
    
    [self.contentView addSubview:self.content];
    
}


//améliore grandement la performance, ne positionne qu'une fois !
-(void)positionner
{
    if(first){
        self.content.frame = CGRectMake(0,0,self.contentView.frame.size.width,MOVIE_CELL_HEIGHT);
        
        self.gradientView.frame = CGRectMake(0.0f, 0.0f, self.content.frame.size.width,self.content.frame.size.height);
        self.gradient.frame = self.gradientView.bounds;
        
        self.gradientViewBlack85.frame = CGRectMake(0.0f, 0.0f, self.content.frame.size.width,self.content.frame.size.height);
        
        self.gradient85.frame = self.gradientViewBlack85.bounds;
        
        
        self.parallaxImage.frame = CGRectMake(0,0,self.contentView.frame.size.width,201);
        self.content.clipsToBounds = YES;
        self.contentView.clipsToBounds = YES;
        self.parallaxImage.clipsToBounds = YES;
        self.parallaxImage.alpha = 0.6f;
        
        self.bottomView.frame = CGRectMake(0,self.content.frame.size.height-18,self.contentView.frame.size.width,18);
        
        self.jaquette.frame = CGRectMake(10,15,85,self.content.frame.size.height-20);
        
        CALayer *layer = self.jaquette.layer;
        layer.shadowOffset = CGSizeMake(2, 2);
        layer.shadowColor = [[UIColor blackColor] CGColor];
        layer.cornerRadius = 0.2f;
        layer.shadowRadius = 3.0f;
        layer.shadowOpacity = 0.80f;
        layer.shadowPath = [[UIBezierPath bezierPathWithRect:layer.bounds] CGPath];
        
        int marginTop = 2;
        int marginLeft = 2;
        
        self.imageJaquette.frame = CGRectMake(0,0,self.jaquette.frame.size.width - marginLeft*2,self.jaquette.frame.size.height - marginTop*2);
        
        self.imageJaquette.center = CGPointMake(self.jaquette.frame.size.width/2, self.jaquette.frame.size.height/2);
        
        {
            self.fondJaquette.frame = self.imageJaquette.bounds;
            
            self.fondJaquette.center = self.imageJaquette.center;
            
            self.gradientFondJaquette.frame = self.fondJaquette.bounds;
            
            self.rouletteFilm.frame = CGRectMake(0, 0, 40, 40);
            self.rouletteFilm.center = self.fondJaquette.center;
        }
        
        self.starRating.frame = CGRectMake(100+self.jaquette.frame.origin.x + self.jaquette.frame.size.width +10 - 124,25, self.content.frame.size.width, 50);
        
        {
            int elementsX = self.jaquette.frame.origin.x + self.jaquette.frame.size.width+ 7;
            int elementY = self.content.frame.size.height - self.bottomView.frame.size.height - 5;
            int elementWidth = self.contentView.frame.size.width - elementsX - 5;
            
            {
                self.styleFilm.text = @" ";
                [self.styleFilm sizeToFit];
                int y = elementY - self.styleFilm.frame.size.height;
                self.styleFilm.frame = CGRectMake(elementsX,y,elementWidth,self.styleFilm.frame.size.height);
                elementY -= self.styleFilm.frame.size.height + 3;
            }
            
            {
                self.titreFilm.text = @" ";
                [self.titreFilm sizeToFit];
                int y = elementY - self.titreFilm.frame.size.height;
                self.titreFilm.frame = CGRectMake(elementsX,y,elementWidth,self.titreFilm.frame.size.height);
                elementY -= self.titreFilm.frame.size.height + 3;
                self.titreFilm.adjustsFontSizeToFitWidth = NO;
                self.titreFilm.lineBreakMode = NSLineBreakByTruncatingTail;
            }
            {
                int width = 125;
                int height = 20;
                int y = elementY - height;
                self.starRating.frame = CGRectMake(elementsX - 5 ,y, width, height);
                elementY -= height;
                
                self.note.frame = CGRectMake(self.starRating.frame.origin.x + self.starRating.frame.size.width + 5,y, self.content.frame.size.width, height);
            }
            
            self.enSalle.frame = CGRectMake(elementsX,elementY - 8,self.content.frame.size.width,40);
            
            self.heureFilm.text = @" ";
            [self.heureFilm sizeToFit];
            self.heureFilm.frame = CGRectMake(elementsX,0,self.contentView.frame.size.width,self.heureFilm.frame.size.height);
            self.heureFilm.center = CGPointMake(self.heureFilm.center.x, self.bottomView.frame.size.height/2);
        }
        
        
        self.viewClick.frame = CGRectMake(0, 0, self.content.frame.size.width, self.content.frame.size.height);
        
    }
    
    
    
    first = NO;
}

-(void)chargerAvecMovie:(Movie *)movie anDelegate:(id)delegate{
    self.movie = movie;
    self.delegate = delegate;
    [self positionner];
    [self remplir];
}

-(void) remplir{
    
    if(self.movie != nil){
        
        
        if(self.movie.title != nil)
            [self.titreFilm setText:self.movie.title];
        else
            [self.titreFilm setText:self.movie.originalTitle];
        
        self.starRating.rating= (self.movie.statistics.userRating + self.movie.statistics.pressRating)/2;
        
        
        NSString * duree = [self.movie getDuree];
        
        if([duree isEqualToString:@"0h00min"])
            [self.heureFilm setText:@""];
        else
            [self.heureFilm setText:duree];
        
        [self.styleFilm setText:[self.movie getGenres]];
        
        [self.imageJaquette sd_setImageWithURL:[NSURL URLWithString:self.movie.poster.href]];
        
        
        [self.parallaxImage sd_setImageWithURL:[NSURL URLWithString:self.movie.defaultMedia.media.thumbnail.href]];
        
        
        self.enSalle.hidden = YES;

        {
            
            if(self.starRating.rating == 0){
                self.starRating.hidden = YES;
                
                [self.note setText:@""];
                
                if (self.movie._release != nil) {
                    
                    @try {
                        
                        NSString * date = [self.movie._release getReleaseDate];
                        
                        int annee = (int)[[[date componentsSeparatedByString: @"/"] objectAtIndex:2] integerValue];
                        
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                        [formatter setDateFormat:@"yyyy"];
                        
                        int anneeEncours = (int)[[formatter stringFromDate:[NSDate date]] integerValue];
                        
                        if (annee >= anneeEncours) {
                            
                            self.enSalle.hidden = NO;
                            
                            [self.enSalle setText:[NSString stringWithFormat:@"En salle le %@",[self.movie._release getReleaseDate]]];
                            
                        }
                        
                    }@catch (NSException * e) {
                        NSLog(@"Exception: %@", e);
                    }
                }
            }else{
                [self.note setText:[NSString stringWithFormat:@"(%.01f)",self.starRating.rating]];
            }
            
        
            
        }
    }
}
-(void)onClick:(id)sender{
    
    [self.delegate onClick:self movie:self.movie];
    
}

-(void)animer
{
    [self.rouletteFilm animer];
    
    self.titreFilm.alpha = 0;
    self.styleFilm.alpha = 0;
    self.note.alpha = 0;
    self.heureFilm.alpha = 0;
    self.starRating.alpha = 0;
    self.jaquette.frame = CGRectMake(-90,self.jaquette.frame.origin.y,self.jaquette.frame.size.width,self.jaquette.frame.size.height);
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^(void) {
        
        self.jaquette.frame = CGRectMake(10,self.jaquette.frame.origin.y,self.jaquette.frame.size.width,self.jaquette.frame.size.height);
        
    } completion:^(BOOL finished) {} ];
    
    [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^(void) {
        self.titreFilm.alpha = 1;
        self.styleFilm.alpha = 1;
        self.heureFilm.alpha = 1;
        self.note.alpha = 1;
        self.starRating.alpha = 1;
        
    } completion:^(BOOL finished) {} ];
}

- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view
{
    
    CGRect rectInSuperview = [tableView convertRect:self.frame toView:view];
    
    float distanceFromCenter = CGRectGetHeight(view.frame)/2 - CGRectGetMinY(rectInSuperview);
    float difference = CGRectGetHeight(self.parallaxImage.frame) - CGRectGetHeight(self.frame);
    float move = (distanceFromCenter / CGRectGetHeight(view.frame)) * difference;
    
    CGRect imageRect = self.parallaxImage.frame;
    imageRect.origin.y = -(difference/2)+move;
    self.parallaxImage.frame = imageRect;
}

@end
