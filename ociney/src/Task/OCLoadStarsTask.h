//
//  OCLoadStarsTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "OCLoadMoviesTask.h"
#import "AllocineResponse.h"

@class OCLoadStarsTask;

@protocol OCLoadStarsTaskDelegate <AsyncTaskDelegate>

-(void)onStarsListRecu:(OCLoadStarsTask*)task starsList:(NSArray *)starsList;
-(void)onStarsListResultatVide:(OCLoadStarsTask*)task;

@end

@interface OCLoadStarsTask : AsyncTask

@property (strong,nonatomic) id<OCLoadStarsTaskDelegate> delegate;

@end

