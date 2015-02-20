//
//  MovieDetailController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 01/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTAppMenuController.h"
#import "Movie.h"
#import "HeaderMovieDetail.h"
#import "MovieDetailContent.h"
#import "LoadMovieFullTask.h"
#import "OCDoubleController.h"
#import "OCLoader.h"
#import "OCMovieViewPager.h"
#import "OCLoadShowTimesTask.h"
#import "MovieDetailTheaterList.h"
#import "OCMovieBandeAnnonceSlider.h"
#import "OCMovieDelegates.h"
#import "OCMovieDetailStarList.h"

@interface MovieDetailController : OCDoubleController<LoadMovieFullTaskDelegate,OCLoadShowTimesDelegate,onPanDelegate,MovideDetailContentDelegate,MovieDetailTheaterListDelegate,OCMovieBandeAnnonceSliderDelegate,OCMovieStarListDelegate>

@property (strong, nonatomic) Movie *movie;
@property (strong,nonatomic) HeaderMovieDetail * headerMovieDetail;
@property (strong,nonatomic) MovieDetailContent * contentMovie;
@property (strong,nonatomic) MovieDetailTheaterList * theaterList;
@property (strong,nonatomic) OCMovieDetailStarList * starList;

@property (strong,nonatomic) OCMovieViewPager *viewPager;
@property (strong,nonatomic) OCMovieBandeAnnonceSlider *viewPagerBa;

@property (strong,nonatomic) CAGradientLayer * gradient100;
@property (strong,nonatomic) UIView * gradientViewBlack100;

@property (strong, nonatomic) LoadMovieFullTask *task;

@property (retain, nonatomic) IBOutlet UIButton *icPictures;
@property (retain, nonatomic) IBOutlet UIButton *icBandeAnnonce;

@end
