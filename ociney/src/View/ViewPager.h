//
//  ViewPager.h
//  ociney
//
//  Created by florent champigny on 24/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface ViewPager : UIView<SwipeViewDataSource,SwipeViewDelegate>

@property (strong, nonatomic) SwipeView *swipeView;

-(void)reloadData;

@end
