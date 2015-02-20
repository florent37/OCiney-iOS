//
//  ColorUtils.h
//  WhatWhat
//
//  Created by Florent Champigny on 14/08/2014.
//  Copyright (c) 2014 Florent Champigny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Constantes.h"

@interface UIColor (Hex)

+(UIColor*)colorFromHexString:(NSString *)hexString;

@end
