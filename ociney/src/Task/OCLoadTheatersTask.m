//
//  OCLoadTheatersTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCLoadTheatersTask.h"

@implementation OCLoadTheatersTask

-(void)doInBackground:(NSArray*)params{
    
    
    /*
     String lat = (String) data[0];
     String lng = (String) data[1];
     List<Theater> theaters = Service.theaterlist(lat, lng, 30, 20, 1);
     */
    
    NSString * lat = [params objectAtIndex:0];
    NSString * lng = [params objectAtIndex:1];
    NSNumber * count = [NSNumber numberWithInt:20];
    NSNumber * page = [NSNumber numberWithInt:1];
    NSNumber * radius = [NSNumber numberWithInt:30];

    
    //String lat, String lng, int radius, int count, int page
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             LAT,lat,
                             LONG,lng,
                             RADIUS,[radius stringValue],
                             COUNT, [count stringValue],
                             PAGE ,[page stringValue], nil];
    
    [self.service theaterlist:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(alloReponse.feed.theater == nil)
            [self.delegate onTheatersListResultatVide:self];
        else
            [self.delegate onTheatersListRecu:self theatherList:alloReponse.feed.theater];

    }
}

@end
