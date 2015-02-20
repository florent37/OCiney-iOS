//
//  OCLoadStarsTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCLoadStarsTask.h"
#import "ServiceSecurity.h"
#import "AllocineResponse.h"

@implementation OCLoadStarsTask

-(void)doInBackground:(NSArray*)params{
    
    NSString * filter = [params objectAtIndex:0];
    NSString * profile = [params objectAtIndex:1];
    NSNumber * count = [params objectAtIndex:2];
    NSNumber * page = [params objectAtIndex:3];
    
    
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:FILTER,filter,
                             PROFILE,profile,
                             COUNT,[count stringValue],
                             PAGE,[page stringValue], nil];
    
    [self.service personList:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(alloReponse.feed.person == nil)
            [self.delegate onStarsListResultatVide:self];
        else
            [self.delegate onStarsListRecu:self starsList:alloReponse.feed.person];
    }
}


@end