//
//  AllocineResponseSmall.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "FeedSmall.h"
#import "Movie.h"
#import "Theater.h"
#import "PersonFull.h"
#import "Protocole.h"

@class PersonSmall;

@interface AllocineResponseSmall : JSONModel

@property (strong, nonatomic) FeedSmall* feed;
@property (strong, nonatomic) Movie* movie;
@property (strong, nonatomic) PersonSmall* person;

@end





