//
//  RechercheTaskMovie.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 21/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "RechercheTaskMovie.h"
#import "AllocineResponse.h"

@implementation RechercheTaskMovie

-(void)doInBackground:(NSArray*)params{
    
    NSString * texte = [params objectAtIndex:0];

    NSNumber * page = [NSNumber numberWithInt:1];
   
    if([params count] > 1)
    page = [params objectAtIndex:1];
    
    texte = [texte stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             Q,texte,
                             FILTER,MOVIE,
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
                
        if (response != nil && response.feed != nil && response.feed.movie != nil)
            [self.delegate onRechercheFilmRecu:self movies:response.feed.movie];
        else
            [self.delegate onRechercheFilmVide:self];
        //      Collections.sort(movies);
        
    }
}

@end
