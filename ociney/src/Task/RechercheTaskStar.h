//
//  RechercheTaskStar.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechercheTask.h"

@class RechercheTaskStar;

@protocol RechercheTaskStarDelegate <AsyncTaskDelegate>

-(void)onRechercheStarRecu:(RechercheTaskStar*)task stars:(NSArray *)listStars;
-(void)onRechercheStarVide:(RechercheTaskStar*)task;

@end

@interface RechercheTaskStar : RechercheTask

@property (strong,nonatomic) id<RechercheTaskStarDelegate> delegate;


@end

