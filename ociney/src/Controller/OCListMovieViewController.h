//
//  OCMovieControllerViewController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 24/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCLoadMoviesTask.h"
#import "OCMovieCell.h"
#import "RechercheTaskMovie.h"
#import "OCListViewController.h"

@interface OCListMovieViewController : OCListViewController <OCLoadMoviesTaskDelegate,OCMovieCellDelegate,RechercheTaskMovieDelegate,CancelSearchDelegate>

@property (strong, nonatomic) OCLoadMoviesTask *task;
// Search movie

@end
