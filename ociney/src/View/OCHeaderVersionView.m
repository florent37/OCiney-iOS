//
//  OCHeaderVersionView.m
//  ociney
//
//  Created by florent champigny on 05/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "OCHeaderVersionView.h"

@implementation OCHeaderVersionView

-(id)initWithImage:(NSString*)image
{
    if(self = [super init])
    {
        self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
        [self addSubview:self.imageView];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.imageView.frame = self.bounds;
}

-(void)tourner:(CGFloat)duration
{
    [self runSpinAnimationOnView:self.imageView duration:duration rotations:1 repeat:0];
}

-(void)arreterTourner
{
    [self.imageView stopAnimating];
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -1 * M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
