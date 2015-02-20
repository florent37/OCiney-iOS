//
//  MovieDetailContent.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "PersonFull.h"
#import "OCMovieDelegates.h"

@protocol MovideDetailContentDelegate
-(void)horairesClicked;
-(void)memberClicked:(PersonFull *)person;
-(void)onMoreStarClicked;
@end

@interface MovieDetailContent : UIView<OCMovieStarListDelegate>

@property (strong,nonatomic) id<MovideDetailContentDelegate> delegate;

@property (strong,nonatomic) Movie * movie;
@property (strong,nonatomic) CastMember * realisateur;

@property (strong,nonatomic) UIView * contentHoraire;
@property (strong,nonatomic) UIView * contentNotes;
@property (strong,nonatomic) UIView * contentSynopsis;
@property (strong,nonatomic) UIView * contentInfo;
@property (strong,nonatomic) UIView * contentCasting;
@property (strong,nonatomic) UIView * contentMembers;

@property (assign,nonatomic) int height;
@property (strong,nonatomic) UIScrollView * scrollContent;
-(void)chargerAvecMovie:(Movie *)movie;


// Content Horaire

@property (strong,nonatomic) UIView * shapeRound;
@property (strong,nonatomic) UIImageView * imageSalle;
@property (strong,nonatomic) UILabel * texteExplication;


// Content Notes

@property (strong,nonatomic) UIView * viewBackSpectateur;
@property (strong,nonatomic) UIView * viewFrontSpectateur;
@property (strong,nonatomic) UIView * viewAvancementSpectateur;
@property (strong,nonatomic) UILabel * noteSpectateur;


@property (strong,nonatomic) UIView * viewBackPresse;
@property (strong,nonatomic) UIView * viewFrontPresse;
@property (strong,nonatomic) UIView * viewAvancementPresse;

@property (strong,nonatomic) UILabel * notePresse;

@property (strong,nonatomic) UILabel * titleNotes;


// Content Synopsis

@property (strong,nonatomic) NSString * synopsis;
@property (strong,nonatomic) UILabel * titleSynopsis;
@property (strong,nonatomic) UILabel * synopsisLabel;

// Content Info

@property(strong,nonatomic) NSString * dateSortie;
@property(strong,nonatomic) NSString * titreOriginal;


@property(strong,nonatomic) UILabel * descriptionDateSortie;
@property(strong,nonatomic) UILabel * descriptionTitreOriginal;
@property(strong,nonatomic) UILabel * valueDateSortie;
@property(strong,nonatomic) UILabel * valueTitreOriginal;

// Content Casting

@property (strong,nonatomic) UIView * fond;
@property (strong,nonatomic) UIView * cercleFond;
@property (strong,nonatomic) UIImageView * imageRealisateur;

@property (strong,nonatomic) UILabel * fonction;
@property (strong,nonatomic) UILabel * nameRealisateur;

@property (strong,nonatomic) UILabel * titleCasting;

@property (strong,nonatomic) UIImageView * plus_dashed_photos_white;
@property (strong,nonatomic) UIImageView * plus_white;

// Content Members


@property (strong,nonatomic) NSArray * castMembers;
@end
