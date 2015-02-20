//
//  AsyncTask.h
//  WhatWhat
//
//  Created by Florent Champigny on 14/08/2014.
//  Copyright (c) 2014 Florent Champigny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllocineService.h"

@class AsyncTask;

@protocol AsyncTaskDelegate

-(void)erreurReseau:(AsyncTask*)task;
-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher;

@end

@interface AsyncTask : NSObject<ServiceDelegate>

@property (strong,nonatomic) AllocineService *service;
@property (strong,nonatomic) id<AsyncTaskDelegate> delegate;
@property (assign,nonatomic) BOOL erreurReseau;

-(id)initWithDelegate:(id)delegate;
-(void)execute:(NSArray*)params;
-(void)onPreExecute;

#pragma mark - To implement

-(void)doInBackground:(NSArray*)params;
-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode;

@end
