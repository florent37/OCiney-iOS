//
//  RechercheTaskMovie.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 21/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechercheTask.h"


@class RechercheTaskMovie;

@protocol RechercheTaskMovieDelegate <AsyncTaskDelegate>

-(void)onRechercheFilmRecu:(RechercheTaskMovie*)task movies:(NSArray *)listMovie;
-(void)onRechercheFilmVide:(RechercheTaskMovie*)task;

@end

@interface RechercheTaskMovie : RechercheTask

@property (strong,nonatomic) id<RechercheTaskMovieDelegate> delegate;


@end
