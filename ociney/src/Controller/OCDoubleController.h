//
//  OCDoubleController.h
//  ociney
//
//  Created by florent champigny on 24/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCDoubleController : UIViewController

@property (assign, nonatomic) float firstX;
@property (assign, nonatomic) float firstY;
@property (assign, nonatomic) CGPoint _origin;
@property (assign, nonatomic) CGPoint _final;
@property (assign, nonatomic) CGFloat duration;

@property (strong, nonatomic) UIView * backEnd;
@property (strong, nonatomic) UIView * frontEnd;

@property (strong,nonatomic) UIImageView * imageProgress;
@property (strong,nonatomic) NSString * url;

@property (assign, nonatomic) NSInteger headerHeight;

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;
-(void)openAndCloseMenu;
-(void)onPan:(UIPanGestureRecognizer *)pan;
-(void)enablePan:(BOOL)enable;
-(void) ajouterImage;
@end
