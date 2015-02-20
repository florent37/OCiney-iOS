//
//  OCHeaderVersionView.h
//  ociney
//
//  Created by florent champigny on 05/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCHeaderVersionView : UIView

@property (strong,nonatomic) UIImageView *imageView;

-(id)initWithImage:(NSString*)image;

-(void)tourner:(CGFloat)duration;
-(void)arreterTourner;

@end
