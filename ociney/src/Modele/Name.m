//
//  Name.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "Name.h"

@implementation Name

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(NSString*)getName
{
    return [NSString stringWithFormat:@"%@ %@",self.given,self.family];
}

@end
