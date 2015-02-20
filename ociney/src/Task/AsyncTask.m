//
//  AsyncTask.m
//  WhatWhat
//
//  Created by Florent Champigny on 14/08/2014.
//  Copyright (c) 2014 Florent Champigny. All rights reserved.
//

#import "AsyncTask.h"

@implementation AsyncTask

-(id)initWithDelegate:(id)delegate{
    if(self = [super init]){
        self.delegate = delegate;
        self.service = [[AllocineService alloc] initWithDelegate:self];
    }
    return self;
}
-(void)execute:(NSArray*)params{
    [self onPreExecute];
    [self doInBackground:params];
}

-(void)onPreExecute{
    if(self.delegate != nil)
        [self.delegate afficherChargement:self afficher:YES];
}

-(void)donneesRecues:(NSString*)donnees andStatusCode:(NSInteger)statusCode andError:(NSError*)error{
    if(error != nil){
        self.erreurReseau = YES;
    }
    [self onPostExecuteOnMainThread:donnees statusCode:statusCode];
}

-(void)onPostExecuteOnMainThread:(id)result statusCode:(NSInteger)statusCode{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self onPostExecute:result statusCode:statusCode];
    });
}

-(void)doInBackground:(NSArray*)params{
}
-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    //[super onPostExecute:result];
    //call the delegate
    if(self.delegate != nil)
        [self.delegate afficherChargement:self afficher:NO];
}


#pragma mark - Copy / Paste thoses functions on implementations !

/*
 
 -(void)doInBackground:(NSArray*)params{
 }
 -(void)onPostExecute:(id)result{
 [super onPostExecute:result];
 }
 
 */

@end
