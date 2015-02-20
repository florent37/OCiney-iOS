//
//  Name.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Name : JSONModel

@property (strong, nonatomic) NSString * given;
@property (strong, nonatomic) NSString * family;

-(NSString*)getName;

@end
