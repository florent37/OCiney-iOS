//
// Created by florent champigny on 23/12/14.
// Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewPager.h"
#import "Movie.h"


@interface OCMovieViewPager : ViewPager

@property (strong, nonatomic) Movie *movie;
@property (strong, nonatomic) NSMutableArray* urlImages;

@end