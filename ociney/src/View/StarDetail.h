//
//  StarDetail.h
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonFull.h"
#import "StarDetailPhotos.h"
#import "OCFilmoGridLayout.h"
#import "StarDetailDelegate.h"

@interface StarDetail : UIView

@property (strong,nonatomic) id<StarDetailDelegate> delegate;
@property (strong,nonatomic) PersonFull* star;

@property (retain,nonatomic) UIView* contentView;
@property (retain,nonatomic) UIScrollView* scrollView;

@property (retain,nonatomic) UILabel* labelDateNaissance;
@property (retain,nonatomic) UILabel* labelDateNaissanceValeur;

@property (retain,nonatomic) UILabel* labelLieuNaissance;
@property (retain,nonatomic) UILabel* labelLieuNaissanceValeur;

@property (retain,nonatomic) UILabel* labelActivites;
@property (retain,nonatomic) UILabel* labelActivitesValeur;

@property (retain,nonatomic) UILabel* separateurBiographie;
@property (retain,nonatomic) UILabel* biographie;

@property (retain,nonatomic) UILabel* separateurFilmographie;
@property (retain,nonatomic) OCFilmoGridLayout* filmographieLayout;

@property (retain,nonatomic) UILabel* separateurPhotos;
@property (retain,nonatomic) StarDetailPhotos* photosLayout;

-(void)loadStarFull:(PersonFull*)starFull;

@end
