//
//  Rendition.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ModelObject.h"
#import "Publication.h"

@interface Rendition : JSONModel

@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString * href;
@property (strong, nonatomic) Publication * publication;
@property (strong, nonatomic) ModelObject * bandwidth;
@property (strong, nonatomic) ModelObject * format;
@property (strong, nonatomic) ModelObject * encodingProfile;
@property (assign, nonatomic) int width;
@property (assign, nonatomic) int height;
@property (assign, nonatomic) int size;

@end
