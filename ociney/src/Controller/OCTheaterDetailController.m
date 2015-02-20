//
//  OCTheaterDetailController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCTheaterDetailController.h"
#import "Color+Hex.h"
#import "Constantes.h"
#import "TTUIScrollViewSlidingPages.h"
#import "OCPosterController.h"
#import "Movie.h"
#import "TheaterShowtime.h"
#import "OCTheaterDetailMovieController.h"
#import "AnalyticsKit.h"

@interface OCTheaterDetailController ()<TTSlidingPagesDataSource,OCLoadTheaterMoviesTaskDelegate,OCPosterControllerDelegate>{
    TTScrollSlidingPagesController *slider;
}

@end

@implementation OCTheaterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AnalyticsKit logScreen:@"TheaterDetail"];
    
    self.content = [[UIView alloc]initWithFrame:CGRectZero];
    
    {
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:@"#333333ff"] CGColor], (id)[[UIColor colorFromHexString:@"#555555ff"] CGColor], nil];
        [self.content.layer insertSublayer:self.gradient atIndex:0];
        
    }
    
    [self.view addSubview:self.content];
    
    [self.content addSubview:self.viewCinema];
    
    self.loader = [OCLoader loader];
    [self.view addSubview:self.loader];
    [self.loader animer];
    self.loader.alpha = 0.4;
    
    self.navigationController.navigationBar.opaque = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    self.task = [[OCLoadTheaterMoviesTask alloc]initWithDelegate:self];
    [self.task execute:@[self.cinema]];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.view.clipsToBounds = YES;
    
    NSInteger firstY = self.navigationController.navigationBar.frame.origin.y + self.navigationController.navigationBar.frame.size.height;
    
    {
        NSInteger margin = 5;
        NSInteger width = 18;
        NSInteger height = width;
        NSInteger y = margin + firstY;
        NSInteger x = self.view.bounds.size.width - width - margin;
        self.loader.frame = CGRectMake(x, y, width, height);
    }
    
    {
        NSInteger y = firstY;
        NSInteger width = self.view.bounds.size.width;
        NSInteger height = self.view.bounds.size.height - y;
        NSInteger x = self.view.bounds.origin.x;
        self.content.frame = CGRectMake(x, y, width, height);
        self.gradient.frame = self.content.bounds;
    }

    
    [self setTitle:self.cinema.name];
    
    {
        NSInteger height = self.viewCinema.frame.size.height;
        NSInteger y = self.content.bounds.size.height-height;
        NSInteger width = self.viewCinema.frame.size.width;
        NSInteger x = 0;
        self.viewCinema.frame = CGRectMake(x, y, width, height);
    }
}

-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return (int)[self.movies count];
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    
    OCPosterController * viewController = [[OCPosterController alloc] init];
    Movie * movie = [self.movies objectAtIndex:index];
    
    viewController.frameContent = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.viewCinema.frame.size.height);
    
    viewController.movie = movie;
    viewController.delegate = self;
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    //all other pages just use a simple text header
    Movie * movie = [self.movies objectAtIndex:index];
    
    title = [[TTSlidingPageTitle alloc] initWithHeaderText:movie.title]; //in reality you would have the correct header text for your page number given by "index"
    
    return title;
}

#pragma mark - OCLoadTheaterMoviesTaskDelegate

-(void)onMoviesListRecu:(OCLoadTheaterMoviesTask*)task movieList:(NSArray *)movies{
    
    self.movies = movies;
    
    slider = [[TTScrollSlidingPagesController alloc] init];
    slider.titleScrollerHidden = YES;
    slider.zoomOutAnimationDisabled = YES;
    slider.dataSource = self;
    slider.disableUIPageControl = YES;
    slider.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.viewCinema.frame.size.height); //I'm setting up the view to be fullscreen in the current view
    
    [self.view addSubview:slider.view];
    
    [self addChildViewController:slider];
    
}

-(void)onPosterSelected:(Movie*)movie
{
    OCTheaterDetailMovieController *controller = [[OCTheaterDetailMovieController alloc] init];
    controller.movie = movie;
    
    [self.cinema getShowTimes: [NSString stringWithFormat:@"%ld",(long)movie.code]];
    
    controller.theater = self.cinema;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)onMoviesListResultatVide:(OCLoadTheaterMoviesTask*)task{
    
}

-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    if(afficher)
    {
        self.loader.hidden = NO;
        [self.loader animer];
    }else{
        self.loader.hidden = YES;
        [self.loader stopAnimating];
    }
}

@end
