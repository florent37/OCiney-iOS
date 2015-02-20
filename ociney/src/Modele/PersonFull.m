//
//  PersonFull.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "PersonFull.h"
#import "PersonSmall.h"

@implementation PersonFull

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(NSString *) getActivities {
    NSString * activities = @"";
    int i = 0;
    
    if([self.activity count] > 0){
        
        for(ModelObject *act in self.activity){
            if(i != 0)
                activities = [activities stringByAppendingString:@" / "];
            
            activities = [activities stringByAppendingString:act.$];
            i++;
            
        }
    }else{
        if(self.activityShort != nil){
            NSString * s = self.activityShort;
            return [s stringByReplacingOccurrencesOfString:@"," withString:@"/"];
        }
    }
    return activities;
}

-(NSString*)getFullName
{
    
    NSString * name = @"";
    
    if(self.name.given !=nil)
        name = [NSString stringWithFormat:@"%@ ",self.name.given];
    
    if(self.name.family !=nil)
        name = [name stringByAppendingString:self.name.family];
    
    return name;
}


+(NSArray *)transformListFull:(NSArray *)persons{
    NSMutableArray * listFull = [[NSMutableArray alloc]init];
    
    for(PersonSmall * p in persons)
        [listFull addObject:[PersonFull transformFull:p]];
    
    return listFull;
}

+(PersonFull *) transformFull:(PersonSmall *)person{
    PersonFull * p = [[PersonFull alloc]init];
    p.activity = person.activity;
    p.code = person.code;
    p.picture = person.picture;
    p.statistics = person.statistics;
    
    Name * name = [[Name alloc]init];
    name.family = person.name;
    name.given = @"";
    p.name = name;
    return p;
}



@end
