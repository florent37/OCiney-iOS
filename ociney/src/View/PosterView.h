//
//  Poster.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface PosterView : UIView

@property (strong,nonatomic) Movie * movie;

@property (strong,nonatomic) UIView * content;
@property (strong,nonatomic) UIImageView * woodframe;
@property (strong,nonatomic) UIImageView * charniereHaute;
@property (strong,nonatomic) UIImageView * charniereBasse;
@property (strong,nonatomic) UIImageView * serrure;
@property (strong,nonatomic) UIImageView * longShaddow;
@property (strong,nonatomic) UIImageView * poster;

@property (strong,nonatomic) UILabel * title;

// Content WoodFrame
@property (strong,nonatomic) UIView * contentWoodFrame;
@property (strong,nonatomic) UIView * bg_darker_poster;
@property (strong,nonatomic) UIImageView * folded_effect;
@property (strong,nonatomic) UIView * gradient_window_view;
@property (strong,nonatomic) CAGradientLayer * gradient_window;
@property (strong,nonatomic) UIImageView * reflet_framewood;
@property (strong,nonatomic) UIView * fondBlack;

-(void)chargerAvecMovie:(Movie *)movie;

@end
