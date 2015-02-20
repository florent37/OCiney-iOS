//
//  OCStarFilmoGrid.h
//  ociney
//
//  Created by florent champigny on 29/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonFull.h"
#import "StarDetailDelegate.h"

@interface OCStarFilmoGrid : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong,nonatomic) PersonFull* star;
@property (strong,nonatomic) UICollectionView *collectionView;

-(void)loadStarFull:(PersonFull*)starFull;
@property (strong,nonatomic) id<StarDetailDelegate> delegate;

@end
