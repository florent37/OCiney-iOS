//
//  Theater.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "Theater.h"

#define TRIM stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]

@implementation Theater

-(id)init
{
    if(self = [super init])
    {
        self.showTimes = (NSMutableArray<TheaterShowtime>*)[NSMutableArray array];
        self.horaires =  (NSMutableArray<Horaires> *)[NSMutableArray array];
        self.horairesSemaine = [NSMutableDictionary dictionary];
        self.horairesSemaineJours = [NSMutableArray array];
    }
    return self;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(void)getShowTimes:(NSString*)idMovie
{
    
    self.horairesSemaine = [NSMutableDictionary dictionary];;
    self.horairesSemaineJours = [NSMutableArray array];
    
    for (TheaterShowtime *t in self.showTimes) {
        if (t.movieShowtimes != nil)
            for (MovieShowtime *mst in t.movieShowtimes) {
                
                BOOL avantPremiere = [mst.preview isEqualToString:@"true"];
                NSString* formatEcran = nil;
                if (mst.screenFormat != nil)
                    formatEcran = mst.screenFormat.$;
                NSString* version = mst.version.$;
                //NSString* display = mst.display;
                
                if (mst.onShow.movie.code == [idMovie intValue]) {
                    
                    if (mst.display != nil && mst.display.length != 0) {
                        NSArray* joursHorraires = [mst.display componentsSeparatedByString:@"Séances du"];
                        
                        for (int i = 0; i < joursHorraires.count; i++) {
                            
                            if (joursHorraires != nil && joursHorraires.count > 0) {
                                
                                @try {
                                    NSArray* jrs = [joursHorraires[i] componentsSeparatedByString:@" : " ];
                                    
                                    if (jrs.count > 1) {
                                        NSString* jour = [jrs[0] TRIM];
                                        NSString* hrs = [jrs[1] TRIM];
                                        
                                        Horaires* horaires = [[Horaires alloc] init];
                                        horaires.avantPremier = avantPremiere;
                                        horaires.display = mst.display;
                                        if (mst.screenFormat != nil)
                                            horaires.formatEcran = mst.screenFormat.$;
                                        horaires.version = version;
                                        horaires.date = jour;
                                        
                                        if ([horaires isMoreThanToday]) {
                                            NSArray* horairesLignes = [hrs componentsSeparatedByString:@","];
                                            for (int j = 0; j < horairesLignes.count; ++j) {
                                                NSString* horraire = [horairesLignes[j] TRIM];
                                                horraire = [[horraire componentsSeparatedByString:@" "][0] TRIM];
                                                
                                                [horaires.seances addObject:horraire];
                                            }
                                            
                                            if (self.horairesSemaine[jour] != nil) {
                                                [self.horairesSemaine[jour] addObject:horaires];
                                            } else {
                                                NSMutableArray *horairesDuJour = [NSMutableArray array];
                                                [horairesDuJour addObject:horaires];
                                                
                                                [self.horairesSemaineJours addObject:jour];
                                                
                                                self.horairesSemaine[jour] = horairesDuJour;
                                            }
                                        }
                                    }
                                    
                                } @catch (NSException* e) {
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
            }
    }
}


@end
