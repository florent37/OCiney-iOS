//
//  OCFilmoElement.h
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FILMO_ELEMENT_TEXT_HEIGHT 20
#define FILMO_ELEMENT_IMAGE_HEIGHT 90
#define FILMO_ELEMENT_HEIGHT (FILMO_ELEMENT_IMAGE_HEIGHT+FILMO_ELEMENT_TEXT_HEIGHT)
#define FILMO_ELEMENT_WIDTH 70

#import "Participation.h"
#import "StarDetailDelegate.h"

@class OCFilmoElement;

@interface OCFilmoElement : UICollectionViewCell

@property (strong,nonatomic) UIImageView *layout;
@property (strong,nonatomic) UIImageView *background;
@property (strong,nonatomic) UIView *gradient;

@property (strong,nonatomic) UIImageView *image;

@property (strong,nonatomic) UIImageView *glass;

@property (strong,nonatomic) UILabel *titre;
@property (strong,nonatomic) UILabel *role;

@property (strong,nonatomic) id<StarDetailDelegate> delegate;
@property (assign,nonatomic) NSInteger index;
@property (assign,nonatomic) BOOL more;
@property (strong,nonatomic) Participation* participation;

@end
