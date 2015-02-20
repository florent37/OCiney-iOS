//
//  HeaderStarDetail.m
//  ociney
//
//  Created by florent champigny on 24/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "HeaderStarDetail.h"
#import "Color+Hex.h"
#import "DateUtils.h"

@interface HeaderStarDetail () {
    CAGradientLayer *starBottomWhiteGradient;
    UIView *starBottomGradientView;
    BOOL first;
}
@end

@implementation HeaderStarDetail

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        first = YES;
    }
    return self;
}

- (void)layoutSubviews {
    if(first){
        first = NO;
        
        [self creer];
    }
}

-(void)creer{
    self.backgroundColor = [UIColor clearColor];
    
    if ([self.star isKindOfClass:[PersonFull class]])
        self.starFull = (PersonFull *) self.star;
    if ([self.star isKindOfClass:[PersonSmall class]])
        self.starSmall = (PersonSmall *) self.star;
    
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
    
    {
        {
            {
                self.starBottomLayout = [UIView new];
                [self addSubview:self.starBottomLayout];
            }
            
            {
                self.starBottomWhiteLayout = [UIView new];
                self.starBottomWhiteLayout.backgroundColor = [UIColor whiteColor];
                [self.starBottomLayout addSubview:self.starBottomWhiteLayout];
                
                {
                    starBottomGradientView = [[UIView alloc] initWithFrame:CGRectZero];
                    starBottomGradientView.alpha = 0.075;
                    
                    starBottomWhiteGradient = [CAGradientLayer layer];
                    starBottomWhiteGradient.colors = @[(id) [[UIColor clearColor] CGColor], (id) [[UIColor blackColor] CGColor]];
                    
                    [starBottomGradientView.layer insertSublayer:starBottomWhiteGradient atIndex:0];
                    [self.starBottomWhiteLayout addSubview:starBottomGradientView];
                    
                }
                
            }
            
            {
                self.starBottomInformationsLayout = [UIView new];
                [self.starBottomWhiteLayout addSubview:self.starBottomInformationsLayout];
            }
        }
        
        {
            self.couronne = [UIImageView new];
            [self.starBottomWhiteLayout addSubview:self.couronne];
            
            self.couronne.image = [UIImage imageNamed:@"ic_cropped_crown"];
            self.couronne.alpha = 0.05;
            self.couronne.contentMode = UIViewContentModeScaleAspectFit;
            self.couronne.hidden = YES;
        }
        
        {
            self.starImage = [UIImageView new];
            self.starImage.contentMode = UIViewContentModeScaleAspectFill;
            [self.starBottomLayout addSubview:self.starImage];
            self.starImage.backgroundColor = [UIColor grayColor];
            [self.starImage sd_setImageWithURL:[NSURL URLWithString:self.star.picture.href]];
            self.starImage.layer.borderWidth = 3.0f;
            self.starImage.layer.borderColor = [UIColor whiteColor].CGColor;
        }
        {
            self.starName = [UILabel new];
            self.starName.font = [UIFont fontWithName:REGULAR size:16];
            self.starName.textColor = [UIColor colorFromHexString:BLACK80];
            
            [self.starBottomInformationsLayout addSubview:self.starName];
            if (self.starSmall != nil)
                self.starName.text = self.starSmall.name;
            else if (self.starFull != nil)
                self.starName.text = [self.starFull.name getName];
        }
        
        {
            self.starInformations = [UILabel new];
            self.starInformations.textColor = [UIColor colorFromHexString:BLACK50];
            self.starInformations.font = [UIFont fontWithName:LIGHT_ITALIC size:12];
            [self.starBottomInformationsLayout addSubview:self.starInformations];
        }
        
        
        {
            self.starPosition = [UIImageView new];
            [self.starBottomWhiteLayout addSubview:self.starPosition];
            self.starPosition.hidden = YES;
            self.starPosition.contentMode = UIViewContentModeScaleAspectFit;
            self.starPosition.alpha = 0.5f;
            
        }
        
        {
            self.loader = [[OCLoader alloc]initWithFrame:CGRectZero];
            self.loader.alpha = 0.5;
            [self.loader animer];
            [self addSubview:self.loader];
            
        }
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self remplir];
}

- (void)remplir {
    
    NSInteger paddingLeft = 10;
    
    { //layouts initialisation
        {
            NSInteger x = 0;
            NSInteger y = 0;
            NSInteger width = (int) self.bounds.size.width;
            NSInteger height = HEADER_STAR_HEIGHT;
            
            self.starBottomLayout.frame = CGRectMake(x, y, width, height);
        }
        
        {
            NSInteger x = 0;
            NSInteger height = 60;
            NSInteger width = (NSInteger) self.starBottomLayout.frame.size.width;
            NSInteger y = (NSInteger) (self.starBottomLayout.bounds.size.height - height);
            
            self.starBottomWhiteLayout.frame = CGRectMake(x, y, width, height);
        }
        
    }
    
    {
        { //image
            NSInteger x = paddingLeft + 0;
            NSInteger height = 90;
            NSInteger width = height;
            NSInteger y = (NSInteger) (self.starBottomLayout.frame.size.height - height - 5);
            
            self.starImage.frame = CGRectMake(x, y, width, height);
            self.starImage.layer.cornerRadius = self.starImage.frame.size.width / 2;
            self.starImage.clipsToBounds = YES;
            
        }
        { //starBottomInformationsLayout
            NSInteger x = (NSInteger) (self.starImage.frame.origin.x + self.starImage.frame.size.width + 5);
            NSInteger y = 0;
            NSInteger width = (NSInteger) (self.starBottomWhiteLayout.frame.size.width - x);
            NSInteger height = (NSInteger) self.starBottomWhiteLayout.frame.size.height;
            
            self.starBottomInformationsLayout.frame = CGRectMake(x, y, width, height);
        }
    }
    
    { //informations layout
        { //textName
            NSInteger x = 0;
            NSInteger y = 10;
            NSInteger height = 0; //sizeToFit
            NSInteger width = (NSInteger) (self.starBottomInformationsLayout.frame.size.width - x);
            
            self.starName.frame = CGRectMake(x, y, width, height);
            [self.starName sizeToFit];
        }
    }
    
    starBottomGradientView.frame = self.starBottomWhiteLayout.bounds;
    starBottomWhiteGradient.frame = starBottomGradientView.bounds;
    
    
    if (self.starFull != nil && self.starFull.birthDate != nil) {
        ModelObject *modelObject = [self.starFull.nationality objectAtIndex:0];
        
        self.starInformations.text = [NSString stringWithFormat:@"%ld ans (%@)", (long) [DateUtils age:self.starFull.birthDate], modelObject.$];
        { //textInfos
            NSInteger x = (NSInteger) self.starName.frame.origin.x;
            NSInteger y = (NSInteger) (self.starName.frame.origin.y + self.starName.frame.size.height + 3);
            NSInteger height = 0; //sizeToFit
            NSInteger width = (NSInteger) (self.starBottomInformationsLayout.frame.size.width - x);
            self.starInformations.frame = CGRectMake(x, y, width, height);
            [self.starInformations sizeToFit];
            self.starInformations.frame = CGRectMake(x, y, width, self.starInformations.frame.size.height);
        }
        
    }
    
    {
        if (self.starFull.statistics != nil) {
            NSInteger top_rank = self.starFull.statistics.rankTopStar;
            
            {
                self.starBottomWhiteLayout.clipsToBounds = YES;
                NSInteger width = 90;
                NSInteger height = 90;
                self.couronne.frame = CGRectMake(self.starBottomWhiteLayout.bounds.size.width - 80, 0, width, height);
                self.couronne.hidden = YES;
            }
            {
                NSInteger width = 25;
                NSInteger height = 25;
                self.starPosition.frame = CGRectMake(self.starBottomWhiteLayout.bounds.size.width - width - 10, self.starBottomWhiteLayout.bounds.size.height - height, width, height);
                self.starPosition.hidden = YES;
                
            }
            
            switch (top_rank) {
                case 1:
                    self.couronne.hidden = NO;
                    self.starPosition.hidden = NO;
                    self.starPosition.image = [UIImage imageNamed:@"ic_topstar_1"];
                    break;
                case 2:
                    self.starPosition.hidden = NO;
                    self.starPosition.image = [UIImage imageNamed:@"ic_topstar_2"];
                    break;
                    
                case 3:
                    self.starPosition.hidden = NO;
                    self.starPosition.image = [UIImage imageNamed:@"ic_topstar_3"];
                    break;
                default:{}
            }
            
        }
    }
    {
        if(self.starBottomWhiteLayout != nil)
        {
            NSInteger margin = 5;
            
            NSInteger height = 20;
            NSInteger width = 20;
            NSInteger x = self.bounds.size.width - width - margin;
            NSInteger y = self.starBottomWhiteLayout.frame.origin.y - height - margin;
            
            self.loader.frame = CGRectMake(x , y, width, height);
        }
        

    }
    
    if(self.starFull != nil){
        self.starImage = nil;
        self.starBottomLayout = nil;
        self.starBottomWhiteLayout = nil;
        self.starBottomInformationsLayout = nil;
        self.starName = nil;
        self.starInformations = nil;
        self.couronne = nil;
        self.starPosition = nil;
    }
}

- (void)loadStarFull:(PersonFull *)starFull {
    self.starFull = starFull;
    [self remplir];
}

@end
