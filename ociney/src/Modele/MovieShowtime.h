//
//  MovieShowtime.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "OnShow.h"
#import "Version.h"
#import "ModelObject.h"
#import "Scr.h"
#import "Protocole.h"

@interface MovieShowtime : JSONModel

@property (strong, nonatomic) NSString* preview;
@property (strong, nonatomic) NSString* releaseWeek;
@property (strong, nonatomic) OnShow* onShow;
@property (strong, nonatomic) Version* version;
@property (strong, nonatomic) ModelObject* screenFormat;
@property (strong, nonatomic) NSString* display;
@property (strong, nonatomic) NSArray<Scr>* scr;

@end
