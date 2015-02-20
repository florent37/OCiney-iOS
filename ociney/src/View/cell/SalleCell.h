//
//  SalleCell.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SALLE_CELL_HEIGHT 115
#import "Theater.h"
#import <CoreLocation/CoreLocation.h>

@interface SalleCell : UITableViewCell

@property (strong,nonatomic) Theater * cinema;


@property (strong,nonatomic) UIView * content;
@property (strong,nonatomic) UIView * splash_stripes_repeat;
@property (strong,nonatomic) UIView * horaires;


@property (strong,nonatomic) UIView * gradient_black50_black20_view;
@property (strong,nonatomic) UIView * gradient_black100_view;


@property (strong,nonatomic) CAGradientLayer * gradient_black50_black20;
@property (strong,nonatomic) CAGradientLayer * gradient_black100;

@property (strong,nonatomic) UIImageView * logo_defaut;
@property (strong,nonatomic) UIImageView * porte;
@property (strong,nonatomic) UIImageView * ic_handicap;
@property (strong,nonatomic) UIImageView * ic_nav;


@property (strong,nonatomic) UILabel * nomCine;
@property (strong,nonatomic) UILabel * adresse;
@property (strong,nonatomic) UILabel * distance;

@property (strong,nonatomic)  CLLocation *fromLocation;



// Fonctions

-(void)chargerAvecSalle:(Theater *)cinema;

@end
