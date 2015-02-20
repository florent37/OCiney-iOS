//
//  Feed.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ModelObject.h"
#import "Movie.h"
#import "TheaterShowtime.h"
#import "Theater.h"
#import "Review.h"
#import "Media.h"
#import "Protocole.h"

@interface Feed : JSONModel

@property (strong, nonatomic) NSString* updated;
@property (assign, nonatomic) int page;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) int totalResults;
@property (strong, nonatomic) NSArray<ModelObject> * results;
@property (strong, nonatomic) NSArray<Movie> * movie;
@property (strong, nonatomic) NSArray<TheaterShowtime> * theaterShowtimes;
@property (strong, nonatomic) NSArray<Theater> * theater;
@property (strong, nonatomic) NSArray<Review> * review;
@property (strong, nonatomic) NSArray<Media> * media;
@property (strong, nonatomic) NSArray<PersonFull>* person;

@end
