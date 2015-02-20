//
//  DefaultMedia.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Media.h"
#import "Protocole.h"

@class Media;

@interface DefaultMedia : JSONModel

@property (strong, nonatomic) Media* media;

@end
