//
//  StarDetailPhotos.h
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCStarPhoto.h"
#import "PersonFull.h"
#import "StarDetailDelegate.h"

@interface StarDetailPhotos : UIView

@property (retain,nonatomic) OCStarPhoto *layoutImage1;
@property (retain,nonatomic) OCStarPhoto *layoutImage2;
@property (retain,nonatomic) OCStarPhoto *layoutImage3;
@property (retain,nonatomic) OCStarPhoto *layoutImage4;

-(void)load:(PersonFull*)personFull;

@property (strong,nonatomic) id<StarDetailDelegate> delegate;

@end
