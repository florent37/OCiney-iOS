//
//  TheaterDetailMovieForeground.h
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "TheaterDetailMoviePageHoraires.h"
#import "HeaderMovieDetail.h"

#import "Movie.h"
#import "Theater.h"

@interface TheaterDetailMovieForeground : UIView<SwipeViewDataSource,SwipeViewDelegate>

@property HeaderMovieDetail *header;
@property SwipeView* swipeView;
@property UIView* backgroundView;

@property Movie* movie;
@property Theater* theater;

@end
