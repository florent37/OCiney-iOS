//
//  Statistics.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ModelObject.h"
#import "Protocole.h"

@interface Statistics : JSONModel

@property (assign, nonatomic) int viewCount;
@property (assign, nonatomic) double userRating;
@property (assign, nonatomic) int userReviewCount;
@property (assign, nonatomic) double pressRating;
@property (assign, nonatomic) int pressReviewCount;
@property (assign, nonatomic) int userRatingCount;
@property (assign, nonatomic) int movieCount;
@property (assign, nonatomic) int movieActorCount;
@property (assign, nonatomic) int movieDirectorCount;
@property (assign, nonatomic) int seriesCount;
@property (assign, nonatomic) int seriesActorCount;
@property (assign, nonatomic) int seriesDirectorCount;
@property (assign, nonatomic) int seriesProducerCount;
@property (assign, nonatomic) int rankTopStar;
@property (assign, nonatomic) int variationTopStar;
@property (assign, nonatomic) int careerDuration;
@property (assign, nonatomic) int editorialRatingCount;
@property (assign, nonatomic) int commentCount;
@property (assign, nonatomic) int photoCount;
@property (assign, nonatomic) int videoCount;
@property (assign, nonatomic) int triviaCount;
@property (assign, nonatomic) int newsCount;
@property (assign, nonatomic) int rankTopMovie;
@property (assign, nonatomic) int variationTopMovie;
@property (assign, nonatomic) int awardCount;
@property (assign, nonatomic) int nominationCount;
@property (assign, nonatomic) int fanCount;
@property (assign, nonatomic) int wantToSeeCount;
@property (assign, nonatomic) int releaseWeekPosition;
@property (assign, nonatomic) int theaterCount;
@property (assign, nonatomic) int theaterCountOnRelease;

@property (strong, nonatomic) NSArray<ModelObject>* rating;


@end
