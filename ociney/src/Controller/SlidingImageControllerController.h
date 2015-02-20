//
//  SlidingImageControllerController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlidingImageControllerController : UIViewController

@property (strong,nonatomic) NSArray * urlImages;
@property (assign,nonatomic) CGRect frame;

-(void)ajouterImages:(NSArray *)urlImage;
@end
