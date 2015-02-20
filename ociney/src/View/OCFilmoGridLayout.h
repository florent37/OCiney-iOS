//
//  OCFilmoGridLayout.h
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCFilmoElement.h"
#import "PersonFull.h"



@interface OCFilmoGridLayout : UIView

@property (strong,nonatomic) NSMutableArray* filmoArray;
@property (strong,nonatomic) PersonFull* star;

@property (strong,nonatomic) id<StarDetailDelegate> delegate;

@end
