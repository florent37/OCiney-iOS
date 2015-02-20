//
//  TheaterShowtime.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "TheaterShowtime.h"

@implementation TheaterShowtime

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(NSArray *) getMovies:(NSArray<TheaterShowtime> *) showTimes andTheather:(Theater *)cinema
{
    
    NSMutableDictionary * movies = [[NSMutableDictionary alloc]init];
    
    @try {
        
        
        for (TheaterShowtime * t in showTimes) {
            if (t.movieShowtimes != nil)
                for (MovieShowtime * mst in t.movieShowtimes) {
                    BOOL avantPremiere = [mst.preview isEqualToString:@"true"];
                    NSString * version = mst.version.$;
                    NSString * screenFormat = mst.screenFormat.$;
                    
                    if (cinema != nil)
                        cinema.showTimes = (NSMutableArray<TheaterShowtime> *)[NSMutableArray arrayWithArray:showTimes];
                    
                    if (mst.onShow != nil && mst.onShow.movie != nil) {
                        
                        Movie * movie = mst.onShow.movie;
                        movie.horaires = (NSMutableArray<Horaires>*)[NSMutableArray array];
                        if ([movies objectForKey:[NSString stringWithFormat:@"%i",movie.code]] == nil){
                            
                            [movies setObject:movie forKey:[NSString stringWithFormat:@"%i",movie.code]];
                            
                        }else {
                            
                            movie = [movies objectForKey:[NSString stringWithFormat:@"%i",movie.code]];
                            
                        }
                        
                        Scr * scr = [mst.scr objectAtIndex:0];
                        
                        if (scr.t != nil) {
                            
                            Horaires * h = [[Horaires alloc]init];
                            h.date = scr.d;
                            h.formatEcran = screenFormat;
                            h.version = version;
                            h.avantPremier = avantPremiere;
                            h.display =mst.display;
                            
                            h.seances = [[NSMutableArray alloc]init];
                            
                            for (ModelObject * s in scr.t) {
                                [h.seances addObject:s.$];
                                
                            }
                            
                            [movie.horaires addObject:h];
                            
                        }
                        
                    }
                    
                }
            
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    
    
    return [movies allValues];
    
}

@end
