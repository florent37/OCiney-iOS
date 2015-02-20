//
//  OCTheaterDetailMovieController.h
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheaterDetailMovieBackground.h"
#import "TheaterDetailMovieForeground.h"

#import "Movie.h"
#import "Theater.h"

#import "OCMovieDelegates.h"
#import "LoadMovieFullTask.h"

@interface OCTheaterDetailMovieController : UIViewController<OCMovieBandeAnnonceSliderDelegate,LoadMovieFullTaskDelegate>

@property (retain,nonatomic) TheaterDetailMovieBackground* background;
@property (retain,nonatomic) TheaterDetailMovieForeground* foreground;

@property (strong,nonatomic) Theater* theater;
@property (strong,nonatomic) Movie* movie;

@end
