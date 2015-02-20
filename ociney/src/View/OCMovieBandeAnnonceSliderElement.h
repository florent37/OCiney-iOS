//
//  OCMovieBandeAnnonceSliderElement.h
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Media.h"
#import "OCMovieDelegates.h"

@interface OCMovieBandeAnnonceSliderElement : UIView

@property (strong,nonatomic) UIView * warfog;
@property (strong,nonatomic) UIImageView * image;
@property (strong,nonatomic) UILabel * titre;
@property (strong,nonatomic) UIView * filtre;
@property (strong,nonatomic) UIImageView * play;
@property (strong,nonatomic) UIView * backgroundTopBorder;
@property (strong,nonatomic) UIView * backgroundBottomBorder;

@property (strong,nonatomic) Media* media;
@property (strong,nonatomic) id<OCMovieBandeAnnonceSliderDelegate> delegate;

@end
