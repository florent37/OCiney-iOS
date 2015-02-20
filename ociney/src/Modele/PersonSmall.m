//
//  PersonSmall.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "PersonSmall.h"

@implementation PersonSmall

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(NSString*)getFullName
{
    return self.name;
}

@end
