//
//  Scr.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 27/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "ModelObject.h"
#import "Protocole.h"

@interface Scr : JSONModel

@property (strong, nonatomic) NSString* d;
@property (strong, nonatomic) NSArray<ModelObject>* t;

@end
