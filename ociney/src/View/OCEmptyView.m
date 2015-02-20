//
//  OCEmptyView.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//
#import "Color+Hex.h"

#import "OCEmptyView.h"

@implementation OCEmptyView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:(CGRect)frame]){

        {
            
            self.gradient = [CAGradientLayer layer];
            self.gradient.colors = @[(id) [[UIColor colorFromHexString:@"#333333ff"] CGColor], (id) [[UIColor colorFromHexString:@"#555555ff"] CGColor]];
            [self.layer insertSublayer:self.gradient atIndex:0];
            
        }
        
        self.ic_in_app_big = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_in_app_big.png"]];
        self.ic_in_app_big.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.ic_in_app_big];
        
        self.empty_message = [UILabel new];
        self.empty_message.textAlignment = NSTextAlignmentLeft;
        [self.empty_message setTextColor:[UIColor colorFromHexString:WHITE70]];
        [self.empty_message setText:@"Aucun résultat trouvé"];
        self.empty_message.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        
        [self addSubview:self.empty_message];
        
    }
    return self;
}

-(void)positionner
{
    self.gradient.frame = self.bounds;
    self.ic_in_app_big.frame = CGRectMake(0, 0, 100, 50);
    self.ic_in_app_big.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 10);
    
    self.empty_message.frame = CGRectMake(0, self.ic_in_app_big.frame.origin.y + self.ic_in_app_big.frame.size.height + 10, 200, 200);
    [self.empty_message sizeToFit];
    self.empty_message.center = CGPointMake(self.frame.size.width/2, self.empty_message.center.y);
}

@end
