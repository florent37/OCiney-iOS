//
//  RechercheTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 21/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"


@class RechercheTask;

@protocol CancelSearchDelegate <AsyncTaskDelegate>

-(void)onCancelSearch;

@end

@interface RechercheTask : AsyncTask

@property (strong,nonatomic) id<CancelSearchDelegate> cancelDelegate;

@end
