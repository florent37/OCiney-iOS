//
//  OCLoadShowTimesTask.m
//  ociney
//
//  Created by Florent on 31/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCLoadShowTimesTask.h"
#import "ServiceSecurity.h"
#import "AllocineResponse.h"
#import "Movie.h"

#define TRIM stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]

@implementation OCLoadShowTimesTask
{
    NSMutableArray *cinemas;
}

-(id)initWithDelegate:(id)delegate andCinemaList:(BOOL)cinemaList
{
    if(self = [super initWithDelegate:delegate])
    {
        self.cinemaList = cinemaList;
    }
    return self;
}

-(void)doInBackground:(NSArray*)params{
    
    Movie* movie = (Movie*) params[0];
    
    if (self.cinemaList) {
        cinemas = (NSMutableArray*) params[1];
        NSMutableString* sb = [NSMutableString new];
        
        NSInteger taille = cinemas.count;
        
        NSNumber * count = [NSNumber numberWithInt:20];
        NSNumber * page = [NSNumber numberWithInt:1];
        
        NSLog(@"CINEMA_TAILLE %ld", (long)taille);
        
        for (NSInteger i = 0; i < taille; ++i) {
            Theater *t = (Theater*)cinemas[i];
            NSLog(@"CINEMA %@", t.code);
            [sb appendString:t.code];
            if (i < taille - 1)
                [sb appendString:@","];
        }
        
        [cinemas removeAllObjects];
        
        [[[AllocineService alloc] initWithDelegate:self] showtimelistForTheaterAndMovie:
         @[
           THEATERS, sb,
           MOVIE, [NSString stringWithFormat:@"%ld",(long)movie.code],
           DATE, [NSDate date],
           COUNT, [count stringValue],
           PAGE, [page stringValue]
           ]
         ];
    }else {
        
        NSString *lat = params[1];
        NSString *lng = params[2];
        
        NSNumber * count = [NSNumber numberWithInt:20];
        NSNumber * page = [NSNumber numberWithInt:1];
        NSNumber * radius = [NSNumber numberWithInt:30];

        
        cinemas = [NSMutableArray array];
        
        [[[AllocineService alloc] initWithDelegate:self] showtimelistWithLatLngAndMovie:
         @[
           LONG, lng,
           LAT, lat,
           RADIUS, [radius stringValue],
           MOVIE, [NSString stringWithFormat:@"%ld",(long)movie.code],
           COUNT, [count stringValue],
           PAGE, [page stringValue]
           ]
         ];
        
    }
}


-(void)onPostExecute:(id)result statusCode:(NSInteger)statusCode{
    [super onPostExecute:result statusCode:statusCode];
    
    if(statusCode == 200){
        NSError *error;
        
        AllocineResponse * alloReponse = [[AllocineResponse alloc] initWithString:result error:&error];
        
        NSArray *theaterShowtime = alloReponse.feed.theaterShowtimes;
        if (theaterShowtime != nil){
            [self loadShowTimes:cinemas showTimes:theaterShowtime ];
            [self.delegate onLoadShowTimesTaskCallBack:cinemas];
        }
        
        if(error != nil)
            NSLog(@"%@",error.description);
    }
}


-(void)loadShowTimes:(NSMutableArray*)theaters showTimes:(NSArray*)showtimes {
    for (TheaterShowtime *ts in showtimes) {
        
        Theater *cinema = ts.place.theater;
        [theaters addObject:cinema];
        
        for (MovieShowtime *mst in ts.movieShowtimes) {
            
            BOOL avantPremiere = [mst.preview isEqualToString:@"true"];
            NSString* formatEcran = nil;
            if (mst.screenFormat != nil)
                formatEcran = mst.screenFormat.$;
            NSString* version = mst.version.$;
            NSString* display = mst.display;
            
            for (Scr *scr in mst.scr) {
                Horaires* horaires = [Horaires new];
                horaires.avantPremier = avantPremiere;
                horaires.display = display;
                horaires.formatEcran = formatEcran;
                horaires.version =version;
                horaires.date = scr.d;
                
                
                for (ModelObject *t in scr.t) {
                    [horaires.seances addObject:t.$];
                }
                
                if (!horaires.seances.count == 0) {
                    [cinema.horaires addObject:horaires];
                }
            }
            
            if (display != nil && !display.length == 0) {
                NSArray* joursHorraires = [display componentsSeparatedByString:@"Séances du"];
                
                for (int i = 0; i < joursHorraires.count; i++) {
                    
                    if (joursHorraires != nil && joursHorraires.count > 0) {
                        
                        @try {
                            NSArray* jrs = [joursHorraires[i] componentsSeparatedByString:@" : "];
                            
                            if (jrs.count > 1) {
                                NSString* jour = [jrs[0] TRIM];
                                NSString* hrs = [jrs[1] TRIM];
                                
                                Horaires* horaires = [Horaires new];
                                horaires.avantPremier = avantPremiere;
                                horaires.display = display;
                                horaires.formatEcran = formatEcran;
                                horaires.version = version;
                                horaires.date = jour;
                                
                                if ([horaires isMoreThanToday]) {
                                    NSArray* horairesLignes = [hrs componentsSeparatedByString:@","];
                                    for (int j = 0; j < horairesLignes.count; ++j) {
                                        NSString* horraire = [[[horairesLignes[j] TRIM] componentsSeparatedByString:@" "][0] TRIM];
                                        [horaires.seances addObject:horraire];
                                    }
                                    
                                    //Log.d("horaires",jour + horaires.getSeances().toString());
                                    
                                    if (cinema.horairesSemaine[jour] != nil) {
                                        [cinema.horairesSemaine[jour] addObject:horaires];
                                    } else {
                                        NSMutableArray* horairesDuJour = [NSMutableArray array];
                                        [horairesDuJour addObject:horaires];
                                        
                                        [cinema.horairesSemaineJours addObject:jour];
                                        cinema.horairesSemaine[jour] = horairesDuJour;
                                    }
                                }
                            }
                            
                        } @catch (NSException *e) {
                            NSLog(@"%@",e);
                        }
                    }
                    
                }
                
            }
        }
    }
}


@end