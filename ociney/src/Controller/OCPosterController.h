//
//  OCPosterController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 05/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterView.h"
#import "Movie.h"

@protocol OCPosterControllerDelegate

-(void)onPosterSelected:(Movie*)movie;

@end

@interface OCPosterController : UIViewController

@property (strong,nonatomic) PosterView * posterView;
@property (strong,nonatomic) Movie * movie;
@property (assign,nonatomic) CGRect frameContent;

@property (strong,nonatomic) id<OCPosterControllerDelegate> delegate;

@end
