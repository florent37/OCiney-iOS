//
//  OCStarController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCLoadStarsTask.h"
#import "OCAppDelegate.h"
#import "OCListViewController.h"

@interface OCStarListController : OCListViewController<OCLoadStarsTaskDelegate>

@property (strong, nonatomic) OCLoadStarsTask *task;
@property (strong,nonatomic)  NSArray * starsDepart;
@end
