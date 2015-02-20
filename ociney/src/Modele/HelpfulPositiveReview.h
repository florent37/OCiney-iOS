//
//  HelpfulPositiveReview.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Writer.h"

@interface HelpfulPositiveReview : JSONModel

@property (assign, nonatomic) int code;
@property (strong, nonatomic) Writer* writer;
@property (strong, nonatomic) NSString* creationDate;
@property (strong, nonatomic) NSString* body;
@property (assign, nonatomic) double rating;

@end
