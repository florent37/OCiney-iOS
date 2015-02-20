//
//  LoadBandeAnnonceFilmTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 31/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "LoadBandeAnnonceFilmTask.h"

@implementation LoadBandeAnnonceFilmTask

-(void)doInBackground:(NSArray*)params{
    
    NSString * idMovie = [params objectAtIndex:0];
    
    NSString * deuxPoint = @"%3A";
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             SUBJECT,[NSString stringWithFormat:@"movie%@%@",deuxPoint,idMovie],
                             COUNT,@"20",
                             MEDIAFMT,@"mp4",
                             nil];
    
    [self.service videoList:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(alloReponse.feed.media == nil)
            [self.delegate onBaRecuVide:self];
       
        else{
                [self.delegate onBaRecu:self ba:alloReponse.feed.media];
            
        }
        

        
    }
}


@end
