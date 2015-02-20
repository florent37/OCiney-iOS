//
//  OCMovieBandeAnnonceSlider.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 31/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewPager.h"
#import "Media.h"
#import "Movie.h"
#import "OCMovieDelegates.h"

@interface OCMovieBandeAnnonceSlider : ViewPager

@property (strong, nonatomic) NSMutableArray<Media>* ba;
@property (strong,nonatomic)  UIImageView * image;
@property (strong,nonatomic)  Movie * movie;

@property (strong,nonatomic) id<OCMovieBandeAnnonceSliderDelegate> delegate;

@end