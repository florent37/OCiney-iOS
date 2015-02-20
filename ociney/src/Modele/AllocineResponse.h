//
//  AllocineResponse.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Feed.h"
#import "Movie.h"
#import "Theater.h"
#import "PersonFull.h"
#import "Protocole.h"

@class PersonFull;

@interface AllocineResponse : JSONModel

@property (strong, nonatomic) Feed* feed;
@property (strong, nonatomic) Movie* movie;
@property (strong, nonatomic) Theater* theater;
//@property (strong, nonatomic) NSArray<PersonFull>* person;
@property (strong, nonatomic) PersonFull* person;

@end

