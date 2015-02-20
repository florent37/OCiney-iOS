//
//  OCStarCell.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCStarCell.h"
#import "UIImageView+WebCache.h"
#import "Color+Hex.h"

@implementation OCStarCell
{
    BOOL first;
}

- (void)awakeFromNib {
    [super layoutSubviews];
    
    first = YES;
    
    self.content = [UIView new];
    
    {
        self.couronne = [UIImageView new];
        
        self.couronne.image = [UIImage imageNamed:@"ic_cropped_crown.png"];
        self.couronne.alpha = 0.05;
        self.couronne.contentMode = UIViewContentModeScaleAspectFit;

        [self.content addSubview:self.couronne];
        
        self.relative_image_fond = [UIView new];
        
        {
            self.gradient_placeholder_view = [[UIView alloc]initWithFrame:CGRectZero];
            [self.relative_image_fond addSubview:self.gradient_placeholder_view];
            
            self.gradient_placeholder = [CAGradientLayer layer];
            self.gradient_placeholder.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:@"#c8c8c8ff"] CGColor], (id)[[UIColor colorFromHexString:@"#aaaaaaff"] CGColor], nil];
            [self.gradient_placeholder_view.layer insertSublayer:self.gradient_placeholder atIndex:0];
            
            self.imageFond = [[UIImageView alloc]initWithFrame:CGRectZero];
            
            self.imageFond.image = [UIImage imageNamed:@"ic_placeholder_people.png"];
            
            [self.relative_image_fond addSubview:self.imageFond];
            
            self.gradient_transparent_white_0deg_view = [[UIView alloc]initWithFrame:CGRectZero];
            
            [self.relative_image_fond addSubview:self.gradient_transparent_white_0deg_view];
            
            self.gradient_transparent_white_0deg = [CAGradientLayer layer];
            // Hoizontal - commenting these two lines will make the gradient veritcal
            self.gradient_transparent_white_0deg.startPoint = CGPointMake(0.0, 0.5);
            self.gradient_transparent_white_0deg.endPoint = CGPointMake(1.0, 0.5);
            self.gradient_transparent_white_0deg.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
            [self.gradient_transparent_white_0deg_view.layer insertSublayer:self.gradient_transparent_white_0deg atIndex:0];
        }
        
        [self.content addSubview:self.relative_image_fond];
        
        
        self.layoutRight = [UIView new];
        
        {
            self.profilUser = [UIView new];
            
            {
                
                self.nomPrenom = [UIView new];
                [self.profilUser addSubview:self.nomPrenom];
                
                self.nameStar = [UILabel new];
                self.nameStar.font = [UIFont fontWithName:REGULAR size:16];
                [self.nameStar setTextColor:[UIColor colorFromHexString:BLACK80]];
                [self.profilUser addSubview:self.nameStar];
                
                self.role = [UILabel new];
                self.role.font = [UIFont fontWithName:LIGHT_ITALIC size:12];
                [self.role setTextColor:[UIColor colorFromHexString:BLACK50]];
                
                
                [self.profilUser addSubview:self.role];
                
                self.ic_topstar = [UIImageView new];
                self.ic_topstar.image = [UIImage imageNamed:@"ic_topstar_1.png"];
                self.ic_topstar.alpha = 0.5f;
                [self.profilUser addSubview:self.ic_topstar];
            }
            
            [self.layoutRight addSubview:self.profilUser];
        }
        
        [self.content addSubview:self.layoutRight];
    }
    
    
    self.gradient_transparent_black_view = [UIView new];
    self.gradient_transparent_black_view.alpha = 0.075;
    self.gradient_transparent_black = [CAGradientLayer layer];
    self.gradient_transparent_black.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    
    
    [self.gradient_transparent_black_view.layer insertSublayer:self.gradient_transparent_black atIndex:0];
    
    [self.content addSubview:self.gradient_transparent_black_view];
    
    
    [self.contentView addSubview:self.content];
}

-(void)chargerAvecStar:(PersonFull *)person{
    self.person = person;
    [self positionner];
    [self remplir];
}

-(void)positionner
{
    if(first){
        self.content.frame = CGRectMake(0,0,self.contentView.frame.size.width,STAR_CELL_HEIGHT);
        self.content.clipsToBounds = YES;
        
        /*
        self.content.layer.shadowRadius = 5.0f;
        self.content.layer.shadowOffset = CGSizeMake(1,0);
        self.content.layer.shadowColor = [UIColor blackColor].CGColor;
        self.content.layer.shadowOpacity = .9f;
         */
        
        [self.content setBackgroundColor:[UIColor whiteColor]];
        
        // Partie de gauche
        
        self.relative_image_fond.frame = CGRectMake(0,0,100,self.content.frame.size.height);
        
        self.gradient_placeholder_view.frame = self.relative_image_fond.bounds;
        self.gradient_placeholder.frame = self.gradient_placeholder_view.bounds;
        
        self.imageFond.frame = self.relative_image_fond.bounds;
        self.imageFond.contentMode = UIViewContentModeScaleAspectFill;
       
        self.gradient_transparent_white_0deg_view.frame = self.relative_image_fond.bounds;
        self.gradient_transparent_white_0deg.frame = self.gradient_transparent_white_0deg_view.bounds;
        
        self.layoutRight.frame = CGRectMake(self.relative_image_fond.frame.size.width,0,self.content.frame.size.width - self.relative_image_fond.frame.size.width,self.content.frame.size.height);
        
        
        self.profilUser.frame = CGRectMake(0,0,self.layoutRight.frame.size.width - 20,50);
        self.profilUser.center = CGPointMake(self.layoutRight.frame.size.width/2, self.layoutRight.frame.size.height/2);
        
        self.role.frame = CGRectMake(0,15,self.profilUser.frame.size.width-20,50);
        
        self.gradient_transparent_black_view.frame = self.content.bounds;
        self.gradient_transparent_black.frame = self.gradient_transparent_black_view.bounds;

        
        first = NO;
    }
}

-(void) remplir{
    
    
    if(self.person != nil){
        
        
        [self.imageFond sd_setImageWithURL:[NSURL URLWithString:self.person.picture.href]];
        
        // Partie de droite
        
         int margin = 0 ;
        
        self.ic_topstar.frame = CGRectZero;
        self.couronne.frame = CGRectZero;

        if (self.person.statistics != nil) {
            int top_rank = self.person.statistics.rankTopStar;
            
            self.ic_topstar.frame = CGRectMake(5,7,25,25);
            self.ic_topstar.contentMode = UIViewContentModeScaleAspectFit;
            margin = 10;

            
            switch (top_rank) {
                case 1:
                    self.ic_topstar.image = [UIImage imageNamed:@"ic_topstar_1.png"];
                    self.ic_topstar.hidden = NO;
                    self.couronne.frame = CGRectMake(self.content.frame.size.width - 90,0,100,100);

                    break;
                case 2:
                    self.ic_topstar.image = [UIImage imageNamed:@"ic_topstar_2.png"];
                    self.ic_topstar.hidden = NO;

                    break;
                    
                case 3:
                    self.ic_topstar.image = [UIImage imageNamed:@"ic_topstar_3.png"];
                    self.ic_topstar.hidden = NO;

                    break;
                default:
                    self.ic_topstar.hidden = true;
                    margin = 0;
                    self.ic_topstar.frame = CGRectZero;
                    break;
            }
            
        }
        
        NSString * name = @" ";
        
        if(self.person.name.given !=nil)
            name = [NSString stringWithFormat:@"%@ ",self.person.name.given];
        
        if(self.person.name.family !=nil)
            name = [name stringByAppendingString:self.person.name.family];
        
        self.nameStar.frame = CGRectMake(self.ic_topstar.frame.size.width + margin,-5,self.profilUser.frame.size.width-self.ic_topstar.frame.size.width - margin,50);
        [self.nameStar setText:name];
        
        @try {
            NSString * activities = [self.person getActivities];
            
            if(activities.length >0){
                [self.role setText:activities];
            } else {
                [self.role setText:@"nr"];
            }
            
        }
        @catch (NSException * e) {
            [self.role setText:@"nr"];
        }
        
    }
}


@end
