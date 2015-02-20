//
//  RechercheTaskStar.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "RechercheTaskStar.h"
#import "AllocineResponseSmall.h"
#import "PersonFull.h"

@implementation RechercheTaskStar

-(void)doInBackground:(NSArray*)params{
    
    NSString * texte = [params objectAtIndex:0];
    
    NSNumber * page = [NSNumber numberWithInt:1];
    
    if([params count] > 1)
        page = [params objectAtIndex:1];
    
    texte = [texte stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             Q,texte,
                             FILTER,@"person",
                             COUNT,@"20",
                             PAGE,[page stringValue],
                             nil];
    
    [self.service search:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponseSmall * response = [[AllocineResponseSmall alloc] initWithString:result error:&error];
        
        if (response != nil && response.feed != nil && response.feed.person != nil)
            [self.delegate onRechercheStarRecu:self stars:[PersonFull transformListFull:response.feed.person]];
        else
            [self.delegate onRechercheStarVide:self];
        
    }
}

@end

