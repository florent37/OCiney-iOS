//
//  OCStarController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCStarListController.h"
#import "OCStarCell.h"
#import "OCStarDetailViewController.h"
#import "RechercheTaskStar.h"
#import "AnalyticsKit.h"

#define IDENTIFIER_STAR @"star"

@interface OCStarListController ()<CancelSearchDelegate,RechercheTaskStarDelegate>
@end

@implementation OCStarListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AnalyticsKit logScreen:@"ListStar"];
    
    self.titleView = @"Stars";
    self.appDelegate.placeholderSearch = @"Rechercher une star";
    
    self.appDelegate.task = [[RechercheTaskStar alloc]initWithDelegate:self];
    self.appDelegate.task.cancelDelegate = self;
    
    self.task = [[OCLoadStarsTask alloc]initWithDelegate:self];
    [self.task execute:@[@"top",@"small",@30, @(self.page)]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //[self scrollViewDidScroll:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_STAR];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"OCStarCell" bundle:nil] forCellReuseIdentifier:IDENTIFIER_STAR];
        cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_STAR];
        [cell awakeFromNib];
    }
    
    cell.contentView.frame = CGRectMake(cell.contentView.frame.origin.x,
                                        cell.contentView.frame.origin.y,
                                        self.tableView.frame.size.width,
                                        cell.contentView.frame.size.height);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.loadMore && indexPath.row == [self.array count] - 5)
    {
        [self launchReload];
    }
    
    return cell;
}


-(void) launchReload{
    self.page++;
    
    self.task = [[OCLoadStarsTask alloc]initWithDelegate:self];
    [self.task execute:@[@"top",@"small",@30, @(self.page)]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STAR_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    OCStarCell *c = (OCStarCell*)cell;
    [c chargerAvecStar:self.array[(NSUInteger) indexPath.row]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super onClick];
    OCStarDetailViewController *controller = [[OCStarDetailViewController alloc] init];
    controller.star = self.array[(NSUInteger) indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}



#pragma mark - OCLoadStarsTaskDelegate

-(void)onStarsListRecu:(OCLoadStarsTask*)task starsList:(NSArray *)starsList{
    [self afficherEmptyView:NO];

    [self.array addObjectsFromArray:starsList];
    
    if(self.page == 1)
        self.starsDepart = [starsList copy];
    [self.tableView reloadData];
}

-(void)onStarsListResultatVide:(OCLoadStarsTask*)task{
    self.loadMore = NO;
    
    if(self.page == 1){
        [self afficherEmptyView:YES];
    }
}


-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:afficher];
}

#pragma mark - CancelSearchDelegate

-(void)onCancelSearch{
    
    if([self.starsDepart count] != 0){
        [self afficherEmptyView:NO];
    }
    
    self.loadMore = YES;
    self.page = 1;
    self.searchOn = NO;
    
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:self.starsDepart];
    [self.tableView reloadData];
}

#pragma mark - RechercheTaskStarDelegate


-(void)onRechercheStarRecu:(RechercheTaskStar*)task stars:(NSArray *)listStars{
    
        [self afficherEmptyView:NO];
    
    if(!self.searchOn){
        self.page = 1;
        self.loadMore = YES;
        [self.array removeAllObjects];
    }
    
    self.searchOn = YES;
    
    [self.array addObjectsFromArray:listStars];
    [self.tableView reloadData];
}

-(void)onRechercheStarVide:(RechercheTaskStar*)task{
    if(self.page == 1){
        [self afficherEmptyView:YES];
    }
}

@end
