//
//  OCEmptyView.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCEmptyView : UIView

@property (strong,nonatomic) UIImageView * ic_in_app_big;
@property (strong,nonatomic) UILabel * empty_message;
@property (strong,nonatomic) CAGradientLayer * gradient;

-(void)positionner;

@end
