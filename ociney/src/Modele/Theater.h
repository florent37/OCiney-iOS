//
//  Theater.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "TheaterShowtime.h"
#import "Horaires.h"
#import "Geoloc.h"
#import "Picture.h"
#import "ModelObject.h"
#import "Protocole.h"

@interface Theater : JSONModel


@property (strong, nonatomic) NSMutableArray<TheaterShowtime> * showTimes;
@property (strong, nonatomic) NSMutableArray<Horaires> * horaires;
@property (strong, nonatomic) NSMutableArray * horairesSemaineJours;
@property (strong, nonatomic) NSMutableDictionary* horairesSemaine;
@property (strong, nonatomic) NSString* code;
@property (assign, nonatomic) double distance;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* postalCode;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) Geoloc* geoloc;
@property (strong, nonatomic) Picture* picture;
@property (strong, nonatomic) NSArray<Link> * link;
@property (strong, nonatomic) ModelObject* cinemaChain;
@property (assign, nonatomic) int screenCount;
@property (assign, nonatomic) int hasPRMAccess;

-(void)getShowTimes:(NSString*)idMovie;

@end
