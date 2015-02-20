//
//  PersonFull.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Name.h"
#import "ModelObject.h"
#import "Person.h"


@interface PersonFull : Person

@property (strong, nonatomic) Name * name;
@property (strong, nonatomic) NSArray<ModelObject> * activity;


-(NSString *) getActivities;
-(NSString*)getFullName;

+(NSArray *)transformListFull:(NSArray *)persons;

@end
