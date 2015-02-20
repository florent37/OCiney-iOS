//
//  CastMember.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "PersonSmall.h"
#import "ModelObject.h"
#import "Picture.h"

@interface CastMember : JSONModel

@property (strong, nonatomic) PersonSmall* person;
@property (strong, nonatomic) ModelObject* activity;
@property (strong, nonatomic) Picture* picture;
@property (strong, nonatomic) NSString* role;


@end
