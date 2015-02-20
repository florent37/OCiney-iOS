//
//  Movie.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Horaires.h"
#import "Media.h"
#import "MovieType.h"
#import "ModelObject.h"
#import "Release.h"
#import "CastingShort.h"
#import "Trailer.h"
#import "Link.h"
#import "Statistics.h"
#import "Poster.h"
#import "News.h"
#import "CastMember.h"
#import "Feature.h"
#import "Trivium.h"
#import "HelpfulPositiveReview.h"
#import "HelpfulNegativeReview.h"
#import "DefaultMedia.h"
#import "Media.h"
#import "Protocole.h"
#import "Horaires.h"

@class MovieType;
@class DefaultMedia;

@interface Movie : JSONModel

@property (strong, nonatomic) NSMutableArray<Horaires> * horaires;
@property (strong, nonatomic) NSArray<Media> * bandesAnnonces;

@property (strong, nonatomic) NSString * duree;
@property (strong, nonatomic) NSString * genres;
@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString * originalTitle;
@property (strong, nonatomic) MovieType * movieType;
@property (strong, nonatomic) NSString * title;
@property (assign, nonatomic) int productionYear;
@property (strong, nonatomic) NSArray<ModelObject> * nationality;
@property (strong, nonatomic) NSArray<ModelObject> * genre;
@property (strong, nonatomic) Release * _release;
@property (strong, nonatomic) ModelObject * color;
@property (strong, nonatomic) NSArray<ModelObject> * language;
@property (strong, nonatomic) CastingShort * CastingShort;
@property (strong, nonatomic) Trailer * trailer;
@property (strong, nonatomic) NSString * trailerEmbed;
@property (strong, nonatomic) NSArray<Link> * link;
@property (strong, nonatomic) Statistics * statistics;
@property (strong, nonatomic) NSString * synopsis;
@property (strong, nonatomic) NSString * synopsisShort;
@property (strong, nonatomic) NSString * keywords;
@property (assign, nonatomic) int runtime;
@property (strong, nonatomic) Poster * poster;
@property (strong, nonatomic) NSArray<CastMember> * castMember;
@property (assign, nonatomic) int hasBluRay;
@property (assign, nonatomic) int hasDVD;
@property (assign, nonatomic) int hasShowtime;
@property (strong, nonatomic) NSString * dvdReleaseDate;
@property (strong, nonatomic) NSString * bluRayReleaseDate;
@property (strong, nonatomic) NSArray<News> * news;
@property (strong, nonatomic) NSArray<Feature> * feature;
@property (strong, nonatomic) NSArray<Trivium> * trivia;
@property (strong, nonatomic) NSArray<HelpfulPositiveReview> * helpfulPositiveReview;
@property (strong, nonatomic) NSArray<HelpfulNegativeReview> * helpfulNegativeReview;
@property (strong, nonatomic) DefaultMedia * defaultMedia;
@property (strong, nonatomic) NSArray<Media> * media;


-(NSString *) getGenres;
-(NSString *) getDuree;
-(CastMember *) getRealisateur;
-(BOOL) sameTitleAndOriginalTitle;
-(NSArray *)getCastMember:(int)number;
-(NSString *) getSynopsisShort;
-(NSString *) getSynopsis;
-(NSMutableArray *) getUrlImages;

-(BOOL)isVF;
-(BOOL)isVO;
-(BOOL)is2D;
-(BOOL)is3D;


@end
