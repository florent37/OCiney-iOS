//
//  Person.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Protocole.h"
#import "Picture.h"
#import "Link.h"
#import "News.h"
#import "Feature.h"
#import "Media.h"
#import "Statistics.h"
#import "Participation.h"

@class ModelObject;

@interface Person : JSONModel

@property (strong, nonatomic) NSArray<ModelObject> * activity;

@property (assign, nonatomic) int code;
@property (assign, nonatomic) int gender;
@property (strong, nonatomic) NSArray<ModelObject> * nationality;
@property (strong, nonatomic) NSString * activityShort;
@property (strong, nonatomic) NSString * biographyShort;
@property (strong, nonatomic) NSString * biography;
@property (strong, nonatomic) NSString * birthDate;
@property (strong, nonatomic) NSString * birthPlace;
@property (strong, nonatomic) Picture * picture;
@property (strong, nonatomic) NSString * trailerEmbed;
@property (assign, nonatomic) int hasTopFilmography;
@property (strong, nonatomic) NSArray<Participation> * participation;
@property (strong, nonatomic) NSArray<Media> * media;
@property (strong, nonatomic) NSArray<Link> * link;
@property (strong, nonatomic) NSArray<News> * news;
@property (strong, nonatomic) NSArray<Feature> * feature;

@property (strong, nonatomic) Statistics * statistics;

-(NSString*)getFullName;

@end
