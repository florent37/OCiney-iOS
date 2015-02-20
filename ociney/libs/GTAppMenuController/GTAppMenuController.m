//
//  GTMainViewController.m
//  GTAppMenuController
//
//  Created by Gianluca Tursi on 24/05/14.
//  Copyright (c) 2014 Gianluca Tursi. All rights reserved.
//

#import "GTAppMenuController.h"
#import "OCAppDelegate.h"
#define kHeaderHeight 60


@interface GTAppMenuController ()
@property (strong, nonatomic) OCAppDelegate *delegate;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
@end

@implementation GTAppMenuController{
    
    float firstX;
    float firstY;
    CGPoint _origin;
    CGPoint _final;
    CGFloat duration;
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = (OCAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.window = self.delegate.frontWindow;
    self.window.layer.shadowRadius = 5.0f;
    self.window.layer.shadowOffset = CGSizeMake(0,0);
    self.window.layer.shadowColor = [UIColor blackColor].CGColor;
    self.window.layer.shadowOpacity = .9f;
    
    duration = .3f;
}

-(void)activateSwipeToOpenMenu:(BOOL)onlyNavigation{
    
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    if (onlyNavigation == YES) {
        [self.navigationBar addGestureRecognizer:_panGesture];
    }else{
        [self.window addGestureRecognizer:_panGesture];
    }
    
    
    
}
-(void)openAndCloseMenu{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    CGPoint finalOrigin;
    CGRect f = self.window.frame;
    
    if (f.origin.y == CGPointZero.y)
        finalOrigin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - kHeaderHeight;
    else
        finalOrigin.y = CGPointZero.y;
    
    finalOrigin.x = 0;
    f.origin = finalOrigin;
    [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.window.transform = CGAffineTransformIdentity;
                         self.window.frame = f;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
    
}

-(void)setAnimationDuration:(CGFloat)d{
    duration = d;
}


- (void)onPan:(UIPanGestureRecognizer *)pan
{
    CGPoint translation = [pan translationInView:self.window];
    CGPoint velocity = [pan velocityInView:self.window];
    
    switch (pan.state) {
            
        case UIGestureRecognizerStateBegan:
            
            _origin = self.window.frame.origin;
            
            break;
        case UIGestureRecognizerStateChanged:
            
            if (_origin.y + translation.y >= 0){
                
                if(self.window.frame.origin.y != CGPointZero.y)
                    self.window.transform = CGAffineTransformMakeTranslation(0, translation.y);
                else
                    self.window.transform = CGAffineTransformMakeTranslation(0, translation.y);
                
            }
            
            break;
        case UIGestureRecognizerStateEnded:
            
        case UIGestureRecognizerStateCancelled:
        {
            CGPoint finalOrigin = CGPointZero;
            if (velocity.y >= 0) {
                finalOrigin.y = CGRectGetHeight([UIScreen mainScreen].bounds) - kHeaderHeight;
            }
            
            CGRect f = self.window.frame;
            f.origin = finalOrigin;
            [UIView animateWithDuration:.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 self.window.transform = CGAffineTransformIdentity;
                                 self.window.frame = f;
                                 
                             } completion:^(BOOL finished) {
                                 
                             }];
            
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
