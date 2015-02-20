//
//  OCRechercheSearchBarController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 23/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCAppDelegate.h"

@interface OCRechercheSearchBarController : UIViewController

@property (assign,nonatomic) BOOL searchOn;
@property (strong,nonatomic) NSString * titleView;
@property (strong,nonatomic) OCAppDelegate * appDelegate;

@end
