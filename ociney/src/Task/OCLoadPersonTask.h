//
//  OCLoadPersonTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "PersonFull.h"
#import "AllocineResponse.h"

@class OCLoadPersonTask;

@protocol OCLoadPersonTaskDelegate <AsyncTaskDelegate>

-(void)onPersonRecu:(OCLoadPersonTask*)task person:(PersonFull *)person;

@end

@interface OCLoadPersonTask : AsyncTask

@property (strong,nonatomic) id<OCLoadPersonTaskDelegate> delegate;

@end

