//
//  OCMovieDetailStarList.h
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "OCMovieDelegates.h"

@interface OCMovieDetailStarList : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) Movie* movie;
@property (strong,nonatomic) UITableView* tableView;

@property (strong,nonatomic) id<OCMovieStarListDelegate> delegate;

@end
