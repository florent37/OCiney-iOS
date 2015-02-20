//
//  OCMovieControllerViewController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 24/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCListMovieViewController.h"
#import "OCMovieCell.h"
#import "OCAppDelegate.h"
#import "MovieDetailController.h"
#import "AnalyticsKit.h"

#define IDENTIFIER_MOVIE @"movie"

@interface OCListMovieViewController ()
{
}
@end

@implementation OCListMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [AnalyticsKit logScreen:@"ListMovie"];
    
    self.titleView = @"Films";
    // On initialise la search bar
    self.appDelegate.placeholderSearch = @"Rechercher un film";
    self.appDelegate.task = [[RechercheTaskMovie alloc]initWithDelegate:self];
    self.appDelegate.task.cancelDelegate = self;
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.translucent = NO;
    [self scrollViewDidScroll:nil];
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_MOVIE];
    
    if(cell == nil){
        [tableView registerNib:[UINib nibWithNibName:@"OCMovieCell" bundle:nil] forCellReuseIdentifier:IDENTIFIER_MOVIE];
        cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER_MOVIE];
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
    
    if(!self.searchOn){
        
        self.task = [[OCLoadMoviesTask alloc]initWithDelegate:self];
        [self.task execute:@[@"nowshowing",@"small",@"toprank", @20, @(self.page)]];
        
    }else{
        [self.appDelegate searchBarMore:(int)self.page];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MOVIE_CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:
(NSIndexPath *)indexPath{
    
    if(self.apparitions.count <= indexPath.row){
        [self.apparitions addObject:@0];
    }
    
    int apparition = [((NSNumber*) self.apparitions[(NSUInteger) indexPath.row]) intValue]+1;
    self.apparitions[(NSUInteger) indexPath.row] = @(apparition);
    
    OCMovieCell *c = (OCMovieCell*)cell;

    [c chargerAvecMovie:self.array[(NSUInteger) indexPath.row] anDelegate:self];
    if(apparition == 1)
        [c animer];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // Get visible cells on table view.
    NSArray *visibleCells = [self.tableView visibleCells];
    
    for (OCMovieCell *cell in visibleCells) {
        [cell cellOnTableView:self.tableView didScrollOnView:self.view];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}


#pragma mark - OCLoadMoviesTaskDelegate


-(void)onMoviesListRecu:(OCLoadMoviesTask*)task moviesList:(NSArray*)moviesList{
    [self afficherEmptyView:NO];

    [self.array addObjectsFromArray:moviesList];
    [self.tableView reloadData];
}

-(void)onMoviesListResultatVide:(OCLoadMoviesTask*)task{
    self.loadMore = NO;
}

#pragma mark - RechercheTaskMovieDelegate


-(void)onRechercheFilmRecu:(RechercheTaskMovie*)task movies:(NSArray *)listMovie{
    
    [self afficherEmptyView:NO];

    if(!self.searchOn){
        self.page = 1;
        self.loadMore = YES;
    }
    self.searchOn = YES;
    
    if(self.page == 1){
        [self.array removeAllObjects];
    }
    
    [self.array addObjectsFromArray:listMovie];
    
    [self.tableView reloadData];
    
    
}

-(void)onRechercheFilmVide:(RechercheTaskMovie*)task{
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
    
    if([self.appDelegate.moviesList count] != 0){
        [self afficherEmptyView:NO];
    }
    
    self.loadMore = YES;
    self.page = 1;
    
    [self.array removeAllObjects];
    [self.array addObjectsFromArray:self.appDelegate.moviesList];
    self.searchOn = NO;
    [self.tableView reloadData];
    
}

#pragma mark - OCMovieCellDelegate

-(void)onClick:(OCMovieCell*)cell movie:(Movie *)movie{
 
    [super onClick];
    MovieDetailController * controller = [[MovieDetailController alloc]init];
    controller.movie = movie;
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end