//
//  NewsSource.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface NewsSource : NSObject

@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* href;

@end
