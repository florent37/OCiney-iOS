//
//  TheaterDetailMoviePageHoraires.h
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheaterDetailMoviePageHoraires : UIView

@property (strong,nonatomic) UILabel *dateLabel;

@property (strong,nonatomic) UIImageView *prevDate;
@property (strong,nonatomic) UIImageView *nextDate;

@property (strong,nonatomic) UIView *divier;

@property (strong,nonatomic) UIView *horaires;

@property (strong,nonatomic) NSString* jour;
@property (strong,nonatomic) NSArray* arrayHoraires;

-(void)loadJour:(NSString*)jour andHoraires:(NSArray*)horaires;

@end
