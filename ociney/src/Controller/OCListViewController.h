//
//  OCListControllerViewController.h
//  ociney
//
//  Created by florent champigny on 25/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCRechercheSearchBarController.h"
#import "OCEmptyView.h"

@interface OCListViewController : OCRechercheSearchBarController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray * array;
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray *apparitions;

@property (assign,atomic) NSInteger page;
@property (assign,atomic) BOOL loadMore;

- (void)onClick;

@property (strong,nonatomic) OCEmptyView * emptyView;

-(void) afficherEmptyView:(BOOL)afficher;

@property (strong,nonatomic) CAGradientLayer * gradient;

@end
