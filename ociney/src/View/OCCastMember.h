//
//  OCCastMember.h
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CastMember.h"
#import "OCMovieDelegates.h"

@interface OCCastMember : UIView

@property (strong,nonatomic) UIView* content;
@property (strong,nonatomic) UIView * fondJaquette;
@property (strong,nonatomic) UIView * fondInformation;
@property (strong,nonatomic) UIImageView * imageCast;
@property (strong,nonatomic) UILabel * nomMember;
@property (strong,nonatomic) UILabel * roles;

@property (strong,nonatomic) CastMember* member;

@property (strong,nonatomic) id<OCMovieStarListDelegate> delegate;

-(void)loadMember:(CastMember*)member;

@end
