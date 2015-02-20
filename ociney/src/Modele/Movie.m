//
//  Movie.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "Movie.h"
#import "ModelObject.h"

@implementation Movie

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(NSString *) getDuree{
    
    if(self.duree == nil){
        int heures = (int) (self.runtime/3600);
        int minutes = (self.runtime / 60 - heures * 60);
        self.duree = [NSString stringWithFormat:@"%ih",heures];
        
        if(minutes<10)
            self.duree = [self.duree stringByAppendingString:@"0"];
        
        self.duree = [self.duree stringByAppendingString:[NSString stringWithFormat:@"%imin",minutes]];
    }
    
    return self.duree;
    
}



-(NSMutableArray *) getUrlImages
{
    NSMutableArray * urlImages = [[NSMutableArray alloc]init];
    
    for(Media * m in self.media){
        if(m.thumbnail != nil && m.thumbnail.href != nil)
            [urlImages addObject:m.thumbnail.href];
    }
    
    return urlImages;
}

-(NSString *) getGenres{
    
    if(self.genres == nil){
        NSString * sb = @"";
        
        int size = (int)[self.genre count];
        
        if(size > 3)
            size = 3;
        
        ModelObject * value;
        for (int i = 0; i < size; ++i) {
            value = [self.genre objectAtIndex:i];
            sb = [sb stringByAppendingString:value.$];
            if(i < size - 1)
                sb = [sb stringByAppendingString:@" / "];
            
        }
        
        self.genres = sb;
    }
    
    return  self.genres;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"class": @"_class",
                                                       @"release":@"_release"
                                                       }];
}


-(CastMember *) getRealisateur
{
    for (CastMember * m in self.castMember) {
        
        @try {
            
            if([m.activity.$ containsString:@"Réalisateur"])
                return m;
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
    }
    return nil;
}

-(BOOL) sameTitleAndOriginalTitle {
    if (self.title != nil)
        return [self.title isEqualToString:self.originalTitle];
    else
        return false;
}


-(NSArray *)getCastMember:(int)number {
    NSMutableArray * cast = [[NSMutableArray alloc]init];
    int i = 0;
    for (CastMember * m in self.castMember) {
        if (![m.activity.$ containsString:@"Réalisateur"]) {
            [cast addObject:m];
            i++;
        }
        
        if (i == number)
            break;
    }
    return cast;
}

-(NSString *) getSynopsis {
    NSString * s = self.synopsis;
    if (s != nil) {
        s = [s stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        s = [s stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
        NSRange r;
        while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
            s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    return s;
}

-(NSString *) getSynopsisShort {
    NSString * s = self.synopsisShort;
    if (s != nil) {
        s = [s stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        s = [s stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
        s = [s stringByReplacingOccurrencesOfString:@"\\<[^>]*>" withString:@""];
        
    }
    return s;
}

-(BOOL)isVF
{
    return YES;
}
-(BOOL)isVO
{
    if (self.language != nil) {
        for (ModelObject* lanquage in self.language) {
            if (![@"Français" isEqualToString:lanquage.$])
                return YES;
        }
        
    }
    return NO;
}
-(BOOL)is2D
{
    return YES;
}
-(BOOL)is3D
{
    if (self._release != nil
        && self._release.releaseVersion != nil
        && [self._release.releaseVersion.$ containsString:@"3D"])
        return YES;
    return NO;
}

@end
