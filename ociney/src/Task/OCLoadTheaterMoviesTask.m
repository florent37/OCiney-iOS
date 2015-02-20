//
//  OCLoadTheaterMoviesTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 08/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCLoadTheaterMoviesTask.h"

@implementation OCLoadTheaterMoviesTask{
    Theater * cinema;
}

-(void)doInBackground:(NSArray*)params{

    cinema = [params objectAtIndex:0];

    //yyyy-MM-dd
    
    NSDate * date = [[NSDate alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    //Optionally for time zone conversions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *d = [formatter stringFromDate:date];
    
    
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             THEATERS,cinema.code,
                             DATE,d,
                             COUNT,[NSString stringWithFormat:@"%i",10],
                             PAGE ,[NSString stringWithFormat:@"%i",1], nil];
    
    [self.service showtimelistForTheater:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(alloReponse.feed.theaterShowtimes == nil)
            [self.delegate onMoviesListResultatVide:self];
        else
            [self.delegate onMoviesListRecu:self movieList:[TheaterShowtime getMovies:alloReponse.feed.theaterShowtimes andTheather:cinema]];
        
    }
}


@end
