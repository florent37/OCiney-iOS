//
//  OCLoader.m
//  ociney
//
//  Created by florent champigny on 25/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCLoader.h"

@implementation OCLoader

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:(CGRect)frame]){
        self.image = [UIImage imageNamed:@"ic_drawer_films.png"];
    }
    return self;
}

+(instancetype)loader
{
    return [[OCLoader alloc] initWithFrame:CGRectZero];
}

-(void)animer
{
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [fullRotation setFromValue:@0.0F];
    [fullRotation setToValue:@((float) ((2 * M_PI)))];
    fullRotation.speed = 5.0f;
    fullRotation.duration = 5.5;
    fullRotation.repeatCount = 1;
    fullRotation.repeatCount = HUGE_VALF;
    [self.layer addAnimation:fullRotation forKey:@"transform.rotation"];
}

@end
