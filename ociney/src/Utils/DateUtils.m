//
//  DateUtils.m
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSInteger)age:(NSString*)birthDate
{
    NSInteger annee = [[birthDate substringWithRange:NSMakeRange(0, 4)] integerValue];
    NSInteger anneeCourate = 0;
    
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        anneeCourate = [[formatter stringFromDate:[NSDate date]] integerValue];
    }
    
    NSInteger age = anneeCourate-annee;
    return age;
}
+(NSString*)formatBithDate:(NSString*)birthDate
{
    NSArray *fields = [birthDate componentsSeparatedByString:@"-"];
    
    if(birthDate == nil || fields.count < 3)
        return @"";
    
    NSInteger annee = [fields[0] integerValue];
    NSInteger mois = [fields[1] integerValue];
    NSInteger jour = [fields[2] integerValue];

    return [NSString stringWithFormat:@"%ld %@ %ld",(long)jour,[DateUtils moisInLetter:mois],(long)annee];
}

+(NSString*)moisInLetter:(NSInteger)mois {
    switch (mois) {
        case 1:
            return NSLocalizedString(@"janvier",nil);
        case 2:
            return NSLocalizedString(@"février",nil);
        case 3:
            return NSLocalizedString(@"mars",nil);
        case 4:
            return NSLocalizedString(@"avril",nil);
        case 5:
            return NSLocalizedString(@"mai",nil);
        case 6:
            return NSLocalizedString(@"juin",nil);
        case 7:
            return NSLocalizedString(@"juillet",nil);
        case 8:
            return NSLocalizedString(@"août",nil);
        case 9:
            return NSLocalizedString(@"septembre",nil);
        case 10:
            return NSLocalizedString(@"octobre",nil);
        case 11:
            return NSLocalizedString(@"novembre",nil);
        case 12:
            return NSLocalizedString(@"décembre",nil);
        default:
            return @"";
    }
}

@end
