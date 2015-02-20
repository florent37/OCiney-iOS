//
//  OCLoadTheatersTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "AllocineResponse.h"


@class OCLoadTheatersTask;

@protocol OCLoadTheatersTaskDelegate <AsyncTaskDelegate>

-(void)onTheatersListRecu:(OCLoadTheatersTask*)task theatherList:(NSArray *)theatherList;
-(void)onTheatersListResultatVide:(OCLoadTheatersTask*)task;

@end

@interface OCLoadTheatersTask : AsyncTask

@property (strong,nonatomic) id<OCLoadTheatersTaskDelegate> delegate;


@end
