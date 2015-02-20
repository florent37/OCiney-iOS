//
//  OCLoadMoviesTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 26/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "AsyncTask.h"
#import "OCLoadMoviesTask.h"
#import "ServiceSecurity.h"
#import "AllocineResponse.h"

@implementation OCLoadMoviesTask


-(void)doInBackground:(NSArray*)params{
 
    NSString * filter = [params objectAtIndex:0];
    NSString * profile = [params objectAtIndex:1];
    NSString * order = [params objectAtIndex:2];
    NSNumber * count = [params objectAtIndex:3];
    NSNumber * page = [params objectAtIndex:4];
    
    
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:FILTER,filter,
                             PROFILE,profile,
                             ORDER,order,
                             COUNT,[count stringValue],
                             PAGE,[page stringValue], nil];

    [self.service movielist:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;

        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(alloReponse.feed.movie == nil)
            [self.delegate onMoviesListResultatVide:self];
        else
            [self.delegate onMoviesListRecu:self moviesList:alloReponse.feed.movie];
    }
}

@end
