//
//  OCTheaterDetailController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theater.h"
#import "OCLoadTheaterMoviesTask.h"
#import "OCLoader.h"

@interface OCTheaterDetailController : UIViewController

@property (strong, nonatomic) OCLoadTheaterMoviesTask *task;

@property (strong,nonatomic) UIView * content;
@property (strong,nonatomic) UIImageView * viewCinema;
@property (strong,nonatomic) CAGradientLayer * gradient;
@property (strong,nonatomic) Theater * cinema;

@property (strong,nonatomic) NSArray * movies;
// Poster

@property (strong,nonatomic) OCLoader* loader;

@end
