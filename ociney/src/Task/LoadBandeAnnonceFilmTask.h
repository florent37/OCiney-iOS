//
//  LoadBandeAnnonceFilmTask.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 31/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsyncTask.h"
#import "AllocineResponse.h"
#import "Movie.h"


@class LoadBandeAnnonceFilmTask;

@protocol LoadBandeAnnonceFilmTaskDelegate <AsyncTaskDelegate>

-(void)onBaRecu:(LoadBandeAnnonceFilmTask*)task ba:(NSArray *)ba;
-(void)onBaRecuVide:(LoadBandeAnnonceFilmTask*)task;

@end

@interface LoadBandeAnnonceFilmTask : AsyncTask

@property (strong,nonatomic) id<LoadBandeAnnonceFilmTaskDelegate> delegate;


@end
