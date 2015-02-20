//
//  OCStarPhoto.h
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCStarPhoto : UIView

@property (retain,nonatomic) UIImageView *image;
@property (retain,nonatomic) UIImageView *background;
@property (retain,nonatomic) UIImageView *glass;

@property (assign,nonatomic) NSInteger padding;

-(void)ajouterOmbre;
-(void)loadImageUrl:(NSString*)url;

@end
