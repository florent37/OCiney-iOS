//
//  ModelObject.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ModelObject : JSONModel

@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString* value;
@property (strong, nonatomic) NSString* $;
@property (assign, nonatomic) int p;
@property (assign, nonatomic) double note;
@property (strong, nonatomic) NSString* type;

@end
