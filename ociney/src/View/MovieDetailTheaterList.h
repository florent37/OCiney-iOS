//
//  MovieDetailTheaterList.h
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Theater.h"

@protocol MovieDetailTheaterListDelegate

-(void)didSelectTheater:(Theater*)theater;

@end

@interface MovieDetailTheaterList : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSMutableArray* array;
@property (strong,nonatomic) UITableView* tableView;

@property (strong,nonatomic) id<MovieDetailTheaterListDelegate> delegate;

-(void)loadTheaters:(NSArray*)array;

@end
