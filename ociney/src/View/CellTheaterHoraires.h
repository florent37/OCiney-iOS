//
//  CellTheaterHoraires.h
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Horaires.h"

@interface CellTheaterHoraires : UIView

@property (strong,nonatomic) UIImageView *version;
@property (strong,nonatomic) UIScrollView *scroll;
@property (strong,nonatomic) UILabel *texte;

-(void)loadHoraires:(Horaires*)horaires;

@end
