//
//  PersonSmall.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Protocole.h"
#import "Statistics.h"
#import "Picture.h"

@interface PersonSmall : JSONModel

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSArray<ModelObject>* activity;
@property (assign, nonatomic) int code;
@property (strong, nonatomic) Statistics * statistics;
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
@property (strong, nonatomic) NSArray<Media> * media;
@property (strong, nonatomic) NSArray<Link> * link;
@property (strong, nonatomic) NSArray<News> * news;
@property (strong, nonatomic) NSArray<Feature> * feature;

-(NSString*)getFullName;

@end
