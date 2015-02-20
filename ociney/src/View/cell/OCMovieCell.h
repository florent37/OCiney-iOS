//
//  OCMovieCell.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 24/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
#import "Movie.h"
#import "OCLoader.h"
#import "OCAppDelegate.h"

#define MOVIE_CELL_HEIGHT 140

@class OCMovieCell;

@protocol OCMovieCellDelegate

-(void)onClick:(OCMovieCell*)cell movie:(Movie *)movie;

@end

@interface OCMovieCell : UITableViewCell

@property (strong,nonatomic) id<OCMovieCellDelegate> delegate;


@property (strong,nonatomic) UIView * content;
@property (strong,nonatomic) UIView * bottomView;
@property (strong,nonatomic) UIView * jaquette;
@property (strong,nonatomic) UIView * fondJaquette;

@property (strong,nonatomic) UIView * gradientView;
@property (strong,nonatomic) UIView * gradientViewBlack85;
@property (strong,nonatomic) UIView * viewClick;

@property (strong,nonatomic) OCAppDelegate * appDelegate;

@property (strong,nonatomic) CAGradientLayer * gradient;
@property (strong,nonatomic) CAGradientLayer * gradient85;
@property (strong,nonatomic) CAGradientLayer * gradientFondJaquette;



@property (strong,nonatomic) UIImageView * parallaxImage;
@property (strong,nonatomic) UIImageView * imageJaquette;
@property (strong,nonatomic) OCLoader * rouletteFilm;

@property (strong,nonatomic) UILabel * titreFilm;
@property (strong,nonatomic) UILabel * enSalle;
@property (strong,nonatomic) UILabel * styleFilm;
@property (strong,nonatomic) UILabel * heureFilm;
@property (strong,nonatomic) UILabel * note;

@property (strong,nonatomic)  EDStarRating * starRating;

@property (strong,nonatomic) Movie * movie;


-(void)chargerAvecMovie:(Movie *)movie anDelegate:(id)delegate;
-(void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;
-(void)animer;

@end
