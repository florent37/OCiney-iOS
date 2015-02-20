//
//  Review.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Writer.h"
#import "Subject.h"
#import "ModelObject.h"
#import "Link.h"
#import "NewsSource.h"

@interface Review : JSONModel

@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString* creationDate;
@property (strong, nonatomic) ModelObject* type;
@property (strong, nonatomic) Subject* subject;
@property (strong, nonatomic) NewsSource* newsSource;
@property (strong, nonatomic) NSString* author;
@property (strong, nonatomic) Link* reviewUrl;
@property (strong, nonatomic) NSString* body;
@property (assign, nonatomic) double rating;
@property (strong, nonatomic) Writer* writer;

@end
