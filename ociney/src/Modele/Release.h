//
//  Release.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ModelObject.h"
#import "Distributor.h"

@interface Release : JSONModel

@property (strong, nonatomic) NSString* releaseDate;
@property (strong, nonatomic) ModelObject* country;
@property (strong, nonatomic) ModelObject* releaseState;
@property (strong, nonatomic) ModelObject* releaseVersion;
@property (strong, nonatomic) Distributor* distributor;


-(NSString *)getReleaseDate;


@end
