//
//  Horaires.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Horaires : JSONModel

@property (assign, nonatomic) bool avantPremier;
@property (strong, nonatomic) NSString * date;
@property (strong, nonatomic) NSString * formatEcran;
@property (strong, nonatomic) NSString * display;
@property (strong, nonatomic) NSMutableArray * seances;
@property (strong, nonatomic) NSString * version;

-(BOOL) isToday;
-(BOOL) isMoreThanToday;

@end
