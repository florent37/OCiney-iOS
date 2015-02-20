//
//  RechercheTaskTheater.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechercheTask.h"


@class RechercheTaskTheater;

@protocol RechercheTaskTheaterDelegate <AsyncTaskDelegate>

-(void)onRechercheTheaterRecu:(RechercheTaskTheater*)task theaters:(NSArray *)listCinemas;
-(void)onRechercheTheaterVide:(RechercheTaskTheater*)task;

@end


@interface RechercheTaskTheater : RechercheTask

@property (strong,nonatomic) id<RechercheTaskTheaterDelegate> delegate;


@end
