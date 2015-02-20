//
//  OCStarDetailViewController.h
//  ociney
//
//  Created by florent champigny on 21/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Person.h"
#import "HeaderStarDetail.h"
#import "UIImageView+WebCache.h"
#import "OCDoubleController.h"
#import "OCLoadPersonTask.h"
#import "StarDetail.h"
#import "OCStarViewPager.h"
#import "OCStarFilmoGrid.h"

#import "StarDetailDelegate.h"

@interface OCStarDetailViewController : OCDoubleController<OCLoadPersonTaskDelegate,StarDetailDelegate>

@property (strong, atomic) Person* star;
@property (retain, nonatomic) IBOutlet HeaderStarDetail* headerStarDetail;
@property (retain, nonatomic) IBOutlet StarDetail* starDetail;

@property (retain, nonatomic) IBOutlet OCStarViewPager * viewPager;
@property (retain, nonatomic) IBOutlet OCStarFilmoGrid * grid;

@property (retain, nonatomic) IBOutlet UIButton *icPictures;
@property (retain, nonatomic) IBOutlet UIButton *icFilmo;

@end
