//
//  TheaterDetailMovieBackground.h
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "OCMovieDelegates.h"

@interface TheaterDetailMovieBackground : UIView

@property (strong,nonatomic) UIImageView* ecran;
@property (strong,nonatomic) UIImageView* rideauBasGauche;
@property (strong,nonatomic) UIImageView* rideauBasDroite;
@property (strong,nonatomic) UIImageView* rideauHautGauche;
@property (strong,nonatomic) UIImageView* rideauHautDroite;
@property (strong,nonatomic) UIImageView* sieges;

@property (strong,nonatomic) Movie* movie;
@property (strong,nonatomic) id<OCMovieBandeAnnonceSliderDelegate> delegate;

-(void)loadMovie:(Movie *)movie;
-(void)animerOuverture;

@end
