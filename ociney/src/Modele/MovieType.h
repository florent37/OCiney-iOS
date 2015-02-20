//
//  MovieType.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "DefaultMedia.h"
#import "Protocole.h"

@class DefaultMedia;

@interface MovieType : JSONModel

@property (strong, nonatomic) DefaultMedia* defaultMedia;

@end
