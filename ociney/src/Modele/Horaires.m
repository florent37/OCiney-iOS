//
//  Horaires.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "Horaires.h"

@implementation Horaires

-(id)init
{
    if(self = [super init])
    {
        self.seances = [NSMutableArray array];
    }
    return self;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

-(BOOL) isToday {
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:self.date];
    
    return [[NSCalendar currentCalendar] isDateInToday:date];
    // NSDate * now = [[NSDate alloc]init];
    
    // return ([now compare:date] == NSOrderedSame);
    
}

-(BOOL) isMoreThanToday {
    
    NSInteger firstSpace = [self.date rangeOfString:@" "].location;
    self.date = [self.date substringFromIndex:firstSpace+1];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMMMM yyyy"];
    dateFormat.locale = [NSLocale localeWithLocaleIdentifier:@"fr_FR"];
    NSDate *date = [dateFormat dateFromString:self.date];
    
    BOOL more = [date compare:[NSDate date]] == NSOrderedDescending;
    return more;
}

@end
