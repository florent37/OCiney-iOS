//
//  TheaterShowtime.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Place.h"
#import "MovieShowtime.h"
#import "Protocole.h"
#import "Theater.h"

@class Place;

@interface TheaterShowtime : JSONModel

@property (strong, nonatomic) Place* place;
@property (strong, nonatomic) NSArray<MovieShowtime> * movieShowtimes;

+(NSArray *) getMovies:(NSArray<TheaterShowtime> *) showTimes andTheather:(NSObject *)cinema;

@end
