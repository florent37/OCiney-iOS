//
//  DateUtils.h
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+(NSInteger)age:(NSString*)birthDate;
+(NSString*)formatBithDate:(NSString*)birthDate;

@end
