//
//  GTMainViewController.h
//  GTAppMenuController
//
//  Created by Gianluca Tursi on 24/05/14.
//  Copyright (c) 2014 Gianluca Tursi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GTAppMenuController : UINavigationController

-(void)activateSwipeToOpenMenu:(BOOL)onlyNavigation;
-(void)openAndCloseMenu;
-(void)setAnimationDuration:(CGFloat)d;

@end
