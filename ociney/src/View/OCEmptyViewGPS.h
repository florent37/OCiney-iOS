//
//  OCEmptyViewGPS.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCEmptyViewGPS : UIView

@property (strong,nonatomic) UIImageView * arrow;
@property (strong,nonatomic) UILabel * gps_not_found_message;

-(void)positionner;


@end
