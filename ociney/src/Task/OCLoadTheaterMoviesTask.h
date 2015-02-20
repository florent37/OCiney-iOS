//
//  OCLoadTheaterMoviesTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 08/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "AllocineResponse.h"


@class OCLoadTheaterMoviesTask;

@protocol OCLoadTheaterMoviesTaskDelegate <AsyncTaskDelegate>

-(void)onMoviesListRecu:(OCLoadTheaterMoviesTask*)task movieList:(NSArray *)movies;
-(void)onMoviesListResultatVide:(OCLoadTheaterMoviesTask*)task;

@end

@interface OCLoadTheaterMoviesTask : AsyncTask

@property (strong,nonatomic) id<OCLoadTheaterMoviesTaskDelegate> delegate;


@end


