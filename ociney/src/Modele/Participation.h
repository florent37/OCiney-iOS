//
//  Participation.h
//  ociney
//
//  Created by florent champigny on 23/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Movie.h"
#import "ModelObject.h"

@protocol Participation
@end

@interface Participation : JSONModel

@property (strong, nonatomic) Movie* movie;
@property (strong, nonatomic) ModelObject* activity;
@property (strong, nonatomic) NSString* role;

@end
