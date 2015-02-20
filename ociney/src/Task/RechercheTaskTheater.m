//
//  RechercheTaskTheater.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "RechercheTaskTheater.h"
#import "AllocineResponse.h"

@implementation RechercheTaskTheater

-(void)doInBackground:(NSArray*)params{
    
    NSString * texte = [params objectAtIndex:0];
    
    NSNumber * page = [NSNumber numberWithInt:1];
    
    if([params count] > 1)
        page = [params objectAtIndex:1];
    
    texte = [texte stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             Q,texte,
                             FILTER,THEATER,
                             COUNT,@"20",
                             PAGE,[page stringValue],
                             nil];
    
    [self.service search:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * response = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if (response != nil && response.feed != nil && response.feed.theater != nil)
            [self.delegate onRechercheTheaterRecu:self theaters:response.feed.theater];
        else
            [self.delegate onRechercheTheaterVide:self];
        
    }
}

@end
