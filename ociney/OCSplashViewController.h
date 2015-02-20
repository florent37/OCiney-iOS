//
//  OCViewController.h
//  ociney
//
//  Created by Florent Champigny on 21/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCLoadMoviesTask.h"

@interface OCSplashViewController : UIViewController <OCLoadMoviesTaskDelegate>

@property (strong, nonatomic) OCLoadMoviesTask *task;

@end
