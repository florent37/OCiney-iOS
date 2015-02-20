//
//  Place.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Theater.h"
#import "Protocole.h"

@class Theater;

@interface Place : JSONModel

@property (strong, nonatomic) Theater* theater;


@end
