//
//  OCStarCell.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonFull.h"

#define STAR_CELL_HEIGHT 70

@interface OCStarCell : UITableViewCell

@property (strong,nonatomic) UIView * content;
@property (strong,nonatomic) UIView * relative_image_fond;
@property (strong,nonatomic) UIView * gradient_placeholder_view;
@property (strong,nonatomic) UIView * gradient_transparent_white_0deg_view;

@property (strong,nonatomic) UIView * layoutRight;
@property (strong,nonatomic) UIView * profilUser;
@property (strong,nonatomic) UIView * nomPrenom;

@property (strong,nonatomic) UIView * gradient_transparent_black_view;



@property (strong,nonatomic) CAGradientLayer * gradient_placeholder;
@property (strong,nonatomic) CAGradientLayer * gradient_transparent_white_0deg;
@property (strong,nonatomic) CAGradientLayer * gradient_transparent_black;


@property (strong,nonatomic) UIImageView * imageFond;
@property (strong,nonatomic) UIImageView * ic_topstar;

@property (strong,nonatomic) UIImageView * couronne;


@property (strong,nonatomic) UILabel * nameStar;
@property (strong,nonatomic) UILabel * role;
@property (strong,nonatomic) PersonFull * person;


-(void)chargerAvecStar:(PersonFull *)person;
@end
