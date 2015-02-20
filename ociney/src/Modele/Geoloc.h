//
//  Geoloc.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Geoloc : JSONModel

@property (assign, nonatomic) double lat;
@property (assign, nonatomic) double _long;

@end
