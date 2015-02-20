//
//  HeaderStarDetail.h
//  ociney
//
//  Created by florent champigny on 24/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Person.h"
#import "UIImageView+WebCache.h"
#import "PersonFull.h"
#import "PersonSmall.h"
#import "OCLoader.h"

#define HEADER_STAR_HEIGHT 100

@interface HeaderStarDetail : UIView

@property (strong,atomic) IBOutlet Person* star;
@property (strong,atomic) IBOutlet PersonFull* starFull;
@property (strong,atomic) IBOutlet PersonSmall* starSmall;

@property (strong,nonatomic) IBOutlet UIImageView* starImage;
@property (strong,nonatomic) IBOutlet UIView* starBottomLayout;
@property (strong,nonatomic) IBOutlet UIView* starBottomWhiteLayout;
@property (strong,nonatomic) IBOutlet UIView* starBottomInformationsLayout;
@property (strong,nonatomic) IBOutlet UILabel* starName;
@property (strong,nonatomic) IBOutlet UILabel* starInformations;
@property (strong,nonatomic) IBOutlet UIImageView* couronne;
@property (strong,nonatomic) IBOutlet UIImageView* starPosition;

@property (strong,nonatomic) OCLoader * loader;

-(void)loadStarFull:(PersonFull*)starFull;

@end
