//
//  LoadMovieFullTask.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 05/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "LoadMovieFullTask.h"
#import "ServiceSecurity.h"
#import "AllocineService.h"
#import "LoadBandeAnnonceFilmTask.h"

@interface LoadMovieFullTask()<LoadBandeAnnonceFilmTaskDelegate>{
    Movie * movie;
}

@end

@implementation LoadMovieFullTask

-(void)doInBackground:(NSArray*)params{
    
    NSString * idMovie = [params objectAtIndex:0];

    
    // PROFILE_LARGE
    // FILTER MOVIE
    NSArray * paramsArray = [[NSArray alloc]initWithObjects:
                             CODE,idMovie,
                             PROFILE,@"large",
                             FILTER,@"movie",
                              nil];
    
    [self.service movie:paramsArray];
}

-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        if(alloReponse.movie == nil)
            [self.delegate onMovieFullRecuVide:self];
        else{
            movie = alloReponse.movie;
            
            LoadBandeAnnonceFilmTask * taskBa = [[LoadBandeAnnonceFilmTask alloc]initWithDelegate:self];
            [taskBa execute:@[[NSString stringWithFormat:@"%i",movie.code]]];
            
        }
    }
}

-(void)onBaRecu:(LoadBandeAnnonceFilmTask*)task ba:(NSArray<Media> *)ba{
    movie.bandesAnnonces = ba;
    [self.delegate onMovieFullRecu:self movie:movie];
}
-(void)onBaRecuVide:(LoadBandeAnnonceFilmTask*)task{
    [self.delegate onMovieFullRecu:self movie:movie];

}

-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    //self.headerMovieDetail.loader.hidden = !afficher;
}

@end
