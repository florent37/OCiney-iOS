//
//  Feature.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Publication.h"
#import "Picture.h"
#import "ModelObject.h"
#import "Protocole.h"

@interface Feature : JSONModel

@property (assign, nonatomic) int code;
@property (strong, nonatomic) Publication* publication;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) Picture* picture;
@property (strong, nonatomic) NSArray<ModelObject>* activity;

@end
