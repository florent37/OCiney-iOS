//
//  HeaderMovieDetail.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
#import "Movie.h"
#import "OCLoader.h"
#import "OCHeaderVersionView.h"

#define MOVIE_HEADER_HEIGHT 130
#define MOVIE_HEADER_ANIMATION 1

@class HeaderMovieDetail;

@protocol onPanDelegate

-(void)onPanJaquette:(UIPanGestureRecognizer *)onPan;

@end

@interface HeaderMovieDetail : UIView

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@property (strong,nonatomic) id<onPanDelegate> delegate;

@property (strong,nonatomic) UIView * jaquette;
@property (strong,nonatomic) UIImageView * parallaxImage;
@property (strong,nonatomic) UIImageView * imageJaquette;


@property (strong,nonatomic) UILabel * titreFilm;
@property (strong,nonatomic) UILabel * styleFilm;
@property (strong,nonatomic) UILabel * heureFilm;

@property (strong,nonatomic)  EDStarRating * starRating;

@property (strong,nonatomic) Movie * movie;

@property (strong,nonatomic) CAGradientLayer * gradient85;
@property (strong,nonatomic) UIView * gradientViewBlack85;

@property (strong,nonatomic) OCLoader * loader;

-(void)chargerAvecMovie:(Movie *)movie;
-(void)chargerVersionsDisponibles;

@property (strong,nonatomic) OCHeaderVersionView * isVO;
@property (strong,nonatomic) OCHeaderVersionView * isVF;
@property (strong,nonatomic) OCHeaderVersionView * is2D;
@property (strong,nonatomic) OCHeaderVersionView * is3D;


@end
