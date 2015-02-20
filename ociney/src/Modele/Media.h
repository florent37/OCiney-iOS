//
//  Media.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "Version.h"
#import "ModelObject.h"
#import "Thumbnail.h"
#import "Statistics.h"
#import "Link.h"
#import "Rendition.h"
#import "Subject.h"


@interface Media : JSONModel

//@SerializedName("class")
@property (strong, nonatomic) NSString* _class;
@property (assign, nonatomic) int code;
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) Thumbnail* thumbnail;
@property (strong, nonatomic) NSArray<Rendition>* rendition;
@property (strong, nonatomic) ModelObject* type;
@property (strong, nonatomic) Version* version;
@property (assign, nonatomic) int runtime;
@property (strong, nonatomic) Statistics* statistics;
@property (strong, nonatomic) NSArray<Link>* link;
@property (strong, nonatomic) NSArray<Subject>* subject;

@end
