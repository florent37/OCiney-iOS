//
//  OCDoubleController.m
//  ociney
//
//  Created by florent champigny on 24/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCDoubleController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Blur.h"
#import "QuartzCore/QuartzCore.h"

#define DOUBLE_CONTROLLER_MARGIN_TOP 40

@interface OCDoubleController (){
    CGRect originalNavigationBarFrame;
    CGRect prevNavigationBarFrame;
    CGRect prevFrontEndFrame;
    BOOL firstAppearance;
}

@end

@implementation OCDoubleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.backEnd = [[UIView alloc]initWithFrame:CGRectZero];
    [self.backEnd setBackgroundColor:[UIColor blackColor]];
    [self.backEnd setUserInteractionEnabled:YES];
    [self.view addSubview:self.backEnd];
    
    
    self.frontEnd = [[UIView alloc]initWithFrame:CGRectZero];
    [self.frontEnd setBackgroundColor:[UIColor clearColor]];
    [self.frontEnd setUserInteractionEnabled:YES];
    [self.view addSubview:self.frontEnd];
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [self enablePan:NO];
    
    self.imageProgress = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.imageProgress.contentMode = UIViewContentModeScaleAspectFill;
    self.imageProgress.backgroundColor = [UIColor blackColor];
    self.imageProgress.userInteractionEnabled = NO;
    
    firstAppearance = YES;
    
    [self.imageProgress sd_setImageWithURL:[NSURL URLWithString:self.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageProgress.image = [self.imageProgress.image blur];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.backEnd.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.imageProgress.frame = self.backEnd.bounds;
    self.frontEnd.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + self.view.bounds.size.height - self.headerHeight, self.view.bounds.size.width, self.view.bounds.size.height - DOUBLE_CONTROLLER_MARGIN_TOP);
    
    if(firstAppearance){
        firstAppearance = false;
        originalNavigationBarFrame = self.navigationController.navigationBar.frame;
    }else{
        self.frontEnd.frame = prevFrontEndFrame;
        
        self.navigationController.navigationBar.frame = prevNavigationBarFrame;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    prevNavigationBarFrame = self.navigationController.navigationBar.frame;
    prevFrontEndFrame = self.frontEnd.frame;
    
    [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.navigationController.navigationBar.frame = originalNavigationBarFrame;
                     } completion:^(BOOL finished) {
                     }];

}

- (void)onPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation = [pan translationInView:self.frontEnd];
    CGPoint velocity = [pan velocityInView:self.frontEnd];
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            
            self._origin = self.frontEnd.frame.origin;
            
            break;
        case UIGestureRecognizerStateChanged:{
            
            NSInteger pos = self._origin.y + translation.y;
            
            //NSLog(@"%ld",pos);
            
            if (pos >= 0){
                float alpha = 1.0-(pos*1.0)/self.frontEnd.frame.size.height;
                if(alpha > 0.8)
                    alpha = 1;
                if(alpha < 0.2)
                    alpha = 0;
                //  NSLog(@"%f",alpha);
                
                self.frontEnd.transform = CGAffineTransformMakeTranslation(0, translation.y);
                self.imageProgress.alpha = alpha;
            }
            
            CGRect navFrame = self.navigationController.navigationBar.frame;
            
            NSInteger posBar = pos - navFrame.size.height;
            if(posBar<20){
                navFrame.origin.y = posBar;
            }
            else if(posBar>navFrame.size.height){
                navFrame.origin.y = originalNavigationBarFrame.origin.y;
            }
            
            self.navigationController.navigationBar.frame = navFrame;
        }
            
            break;
        case UIGestureRecognizerStateEnded:
            
        case UIGestureRecognizerStateCancelled:
        {
            CGRect navFrame = self.navigationController.navigationBar.frame;
            
            CGPoint finalOrigin = CGPointZero;
            if (velocity.y >= 0) {
                self.imageProgress.alpha = 0;
                navFrame.origin.y = originalNavigationBarFrame.origin.y;
                finalOrigin.y = self.view.frame.size.height - self.headerHeight;
                
            }else{
                self.imageProgress.alpha = 1;
                finalOrigin.y = DOUBLE_CONTROLLER_MARGIN_TOP;
                navFrame.origin.y = -navFrame.size.height;
            }
            
            CGRect f = self.frontEnd.frame;
            f.origin = finalOrigin;
            
            [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 self.frontEnd.transform = CGAffineTransformIdentity;
                                 self.frontEnd.frame = f;
                                 self.navigationController.navigationBar.frame = navFrame;
                             } completion:^(BOOL finished) {
                                 
                             }];
            
        }
            break;
            
        default:
            break;
    }
}

-(void)enablePan:(BOOL)enable
{
    if(enable)
    {
        [self.frontEnd addGestureRecognizer:_panGesture];
    }else{
        [self.frontEnd removeGestureRecognizer:_panGesture];
    }
}

-(void)openAndCloseMenu{

    CGPoint finalOrigin;
    CGRect f = self.frontEnd.frame;
    int alpha = 0;
    CGRect navFrame = self.navigationController.navigationBar.frame;
    
    if (f.origin.y == DOUBLE_CONTROLLER_MARGIN_TOP){
        alpha = 0;
        navFrame.origin.y = originalNavigationBarFrame.origin.y;
        finalOrigin.y = self.view.frame.size.height - self.headerHeight;
    }else {
        alpha = 1;
        finalOrigin.y = DOUBLE_CONTROLLER_MARGIN_TOP;
        navFrame.origin.y = -navFrame.size.height;
    }

    finalOrigin.x = 0;
    f.origin = finalOrigin;
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.frontEnd.transform = CGAffineTransformIdentity;
                         self.frontEnd.frame = f;
                         self.navigationController.navigationBar.frame = navFrame;
                         self.imageProgress.alpha = alpha;
                     } completion:^(BOOL finished) {
                     }];

}

-(void) ajouterImage{
    if(self.imageProgress.superview != nil)
        [self.imageProgress removeFromSuperview];
    
    [self.backEnd addSubview:self.imageProgress];
}

@end
