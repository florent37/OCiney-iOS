//
//  Service.h
//  WhatWhat
//
//  Created by Florent Champigny on 14/08/2014.
//  Copyright (c) 2014 Florent Champigny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


#define ALLOCINE_PARTNER_KEY @"100043982026"
#define ALLOCINE_SECRET_KEY @"29d185d98c984a359e6e6f26a0474269"
#define APP_ID @"27405"
#define FORMAT_JSON @"json"

#define URL @"http://api.allocine.fr/rest/v3"
#define USER_AGENT @"Dalvik/1.6.0 (Linux; U; Android 4.2.2; Nexus 4 Build/JDQ39E)"

#define PARTNER @"partner"
#define CODE @"code"
#define COUNT @"count"
#define ORDER @"order"
#define FILTER @"filter"
#define FORMAT @"format"


#define SED @"sed"
#define SIG @"sig"
#define Q @"q"
#define PAGE @"page"
#define PROFILE @"profile"
#define ZIP @"zip"
#define LAT @"lat"
#define LONG @"long"
#define RADIUS @"radius"
#define THEATER @"theater"
#define LOCATION @"location"
#define TYPE @"type"
#define MOVIE @"movie"
#define DATE @"date"
#define THEATERS @"theaters"
#define SUBJECT @"subject"
#define MEDIAFMT @"mediafmt"

@protocol ServiceDelegate

-(void)donneesRecues:(NSString*)donnees andStatusCode:(NSInteger)statusCode andError:(NSError*)error;

@end

@interface AllocineService : NSObject


-(id)initWithDelegate:(id<ServiceDelegate>) serviceDelegate;

@property (strong, nonatomic) id<ServiceDelegate> serviceDelegate;

-(void)movie:(NSArray *)parametres;
-(void)person:(NSArray *)parametres;
-(void)movielist:(NSArray *)parametres;
-(void)personList:(NSArray *)parametres;
-(void)search:(NSArray *)paramsArray;
-(void)theaterlist:(NSArray *)paramsArray;
-(void)showtimelistForTheater:(NSArray *)showtimelistForTheater;
-(void)showtimelistForTheaterAndMovie:(NSArray *)paramsArray;
-(void)showtimelistWithLatLngAndMovie:(NSArray *)paramsArray;
-(void)videoList:(NSArray *)parametres;

@end
