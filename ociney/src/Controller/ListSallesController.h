//
//  ListSallesController.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCListViewController.h"
#import "OCLoadTheatersTask.h"
#import <CoreLocation/CoreLocation.h>
#import "OCEmptyViewGPS.h"

@interface ListSallesController : OCListViewController<OCLoadTheatersTaskDelegate>

@property (strong, nonatomic) OCLoadTheatersTask *task;
@property (strong,nonatomic)  CLLocationManager *locationManager;

@property (strong,nonatomic) NSArray * salleDepart;

@property (strong,nonatomic) OCEmptyViewGPS * empty_gps;

@end
