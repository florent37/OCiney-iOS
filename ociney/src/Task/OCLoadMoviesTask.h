//
//  OCLoadMoviesTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 26/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "AsyncTask.h"
#import "OCLoadMoviesTask.h"
#import "AllocineResponse.h"

@class OCLoadMoviesTask;

@protocol OCLoadMoviesTaskDelegate <AsyncTaskDelegate>

-(void)onMoviesListRecu:(OCLoadMoviesTask*)task moviesList:(NSArray *)moviesList;
-(void)onMoviesListResultatVide:(OCLoadMoviesTask*)task;

@end

@interface OCLoadMoviesTask : AsyncTask

@property (strong,nonatomic) id<OCLoadMoviesTaskDelegate> delegate;

@end

