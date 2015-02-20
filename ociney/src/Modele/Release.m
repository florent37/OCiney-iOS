//
//  Release.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "Release.h"

@implementation Release

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"release":@"_release"
                                                       }];
}


-(NSString *)getReleaseDate{
    
    @try {
        NSArray * releaseCut = [self.releaseDate componentsSeparatedByString: @"-"];
        
        return [NSString stringWithFormat:@"%@/%@/%@",[releaseCut objectAtIndex:2],[releaseCut objectAtIndex:1],[releaseCut objectAtIndex:0]];
        
    }
    @catch (NSException *exception) {
        return self.releaseDate;
   
    }
}

@end
