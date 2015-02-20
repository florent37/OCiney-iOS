//
//  Version.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Version : JSONModel

@property (strong, nonatomic) NSString* original;
@property (assign, nonatomic) int code;
@property (assign, nonatomic) int lang;
@property (strong, nonatomic) NSString* $;

@end
