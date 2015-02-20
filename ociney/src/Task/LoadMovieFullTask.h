//
//  LoadMovieFullTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 05/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "AllocineResponse.h"
#import "Movie.h"

@class LoadMovieFullTask;

@protocol LoadMovieFullTaskDelegate <AsyncTaskDelegate>

-(void)onMovieFullRecu:(LoadMovieFullTask*)task movie:(Movie *)movie;
-(void)onMovieFullRecuVide:(LoadMovieFullTask*)task;

@end

@interface LoadMovieFullTask : AsyncTask

@property (strong,nonatomic) id<LoadMovieFullTaskDelegate> delegate;


@end

