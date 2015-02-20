//
//  OCLoadStarsTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCLoadPersonTask.h"
#import "ServiceSecurity.h"
#import "AllocineResponse.h"

@implementation OCLoadPersonTask

-(void)doInBackground:(NSArray*)params{
    
    NSString * code = [params objectAtIndex:0];
    
    NSArray * paramsArray = @[
                             CODE,code,
                             PROFILE,@"large",
                             FILTER,@"person",
                             ];
    
    [self.service person:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(error != nil)
            NSLog(@"%@",error.description);
        
        if(alloReponse.person != nil)
            [self.delegate onPersonRecu:self person:alloReponse.person];
    }
}


@end