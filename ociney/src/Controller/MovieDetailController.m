//
//  MovieDetailController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 01/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "MovieDetailController.h"
#import "UIImageView+WebCache.h"
#import "Color+Hex.h"
#import "OCAppDelegate.h"
#import "DKScrollingTabController.h"
#import "TTUIScrollViewSlidingPages.h"
#import "OCTheaterDetailMovieController.h"
#import <CoreLocation/CoreLocation.h>
#import "OCStarDetailViewController.h"
#import "AnalyticsKit.h"

@import MediaPlayer;


@interface MovieDetailController ()<CLLocationManagerDelegate>{
    OCAppDelegate * appDelegate;
    CLLocationManager *locationManager;
}

@end

@implementation MovieDetailController

- (void)viewDidLoad {
    
    [AnalyticsKit logScreen:@"MovieDetail"];
    
    self.url = self.movie.poster.href;
    [super viewDidLoad];
    
    self.headerHeight = MOVIE_HEADER_HEIGHT;
    
    appDelegate = (OCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    self.gradientViewBlack100 = [[UIView alloc]initWithFrame:CGRectZero];
    [self.frontEnd addSubview:self.gradientViewBlack100];
    
    self.gradient100 = [CAGradientLayer layer];
    self.gradient100.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:@"#000000d9"] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.gradientViewBlack100.layer insertSublayer:self.gradient100 atIndex:0];
    
    
    self.headerMovieDetail = [[HeaderMovieDetail alloc]initWithFrame:CGRectZero];
    self.headerMovieDetail.delegate = self;
    [self.headerMovieDetail setBackgroundColor:[UIColor clearColor]];
    [self.frontEnd addSubview:self.headerMovieDetail];
    
    self.viewPager = [OCMovieViewPager new];
    [self.backEnd addSubview:self.viewPager];
    
    self.viewPagerBa = [OCMovieBandeAnnonceSlider new];
    self.viewPagerBa.delegate =self;
    self.viewPagerBa.hidden = YES;
    [self.backEnd addSubview:self.viewPagerBa];
    
    self.theaterList = [MovieDetailTheaterList new];
    self.theaterList.delegate = self;
    [self.backEnd addSubview:self.theaterList];
    self.theaterList.hidden = YES;
    
    self.starList = [OCMovieDetailStarList new];
    self.starList.delegate = self;
    [self.backEnd addSubview:self.starList];
    self.starList.hidden = YES;
    
    [self ajouterImage];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.task == nil){
        self.task = [[LoadMovieFullTask alloc]initWithDelegate:self];
        [self.task execute:@[[NSString stringWithFormat:@"%i",self.movie.code]]];
    }
    
}

-(void)icPicturesTap{
    self.icBandeAnnonce.selected = NO;
    self.icPictures.selected = YES;
    
    self.viewPagerBa.hidden = YES;
    self.viewPager.hidden = NO;
    self.starList.hidden = YES;
    self.theaterList.hidden = YES;
}

-(void)icBaTap{
    self.icBandeAnnonce.selected = YES;
    self.icPictures.selected = NO;
    
    self.viewPagerBa.hidden = NO;
    self.viewPager.hidden = YES;
    self.starList.hidden = YES;
    self.theaterList.hidden = YES;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.icBandeAnnonce.hidden = YES;
        self.icPictures.hidden = YES;
    } completion:^(BOOL finished) {
        [self.icBandeAnnonce removeFromSuperview];
        [self.icPictures removeFromSuperview];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setTitle:@""];
    
    {
        self.icPictures  = [UIButton new];
        self.icBandeAnnonce  = [UIButton new];
        
        [self.icPictures setImage:[UIImage imageNamed:@"ic_picture_30"] forState:UIControlStateNormal];
        [self.icPictures setImage:[UIImage imageNamed:@"ic_picture_80"] forState:UIControlStateHighlighted];
        [self.icPictures setImage:[UIImage imageNamed:@"ic_picture_80"] forState:UIControlStateSelected];
        
        [self.icPictures addTarget:self action:@selector(icPicturesTap) forControlEvents:UIControlEventTouchUpInside];
        
        [self.icBandeAnnonce setImage:[UIImage imageNamed:@"ic_bandeannonce_30"] forState:UIControlStateNormal];
        [self.icBandeAnnonce setImage:[UIImage imageNamed:@"ic_bandeannonce_80"] forState:UIControlStateHighlighted];
        [self.icBandeAnnonce setImage:[UIImage imageNamed:@"ic_bandeannonce_80"] forState:UIControlStateSelected];
        
        [self.icBandeAnnonce addTarget:self action:@selector(icBaTap) forControlEvents:UIControlEventTouchUpInside];
        
        [self.navigationController.navigationBar.viewForBaselineLayout addSubview:self.icPictures];
        [self.navigationController.navigationBar.viewForBaselineLayout addSubview:self.icBandeAnnonce];
    }
    
    self.icPictures.selected = YES;
    
    
    self.gradientViewBlack100.frame = CGRectMake(0.0f, self.headerHeight, self.frontEnd.frame.size.width,self.frontEnd.frame.size.height- self.headerHeight);
    
    self.gradient100.frame = self.gradientViewBlack100.bounds;
    
    self.viewPager.frame = self.backEnd.bounds;
    self.viewPagerBa.frame = self.backEnd.bounds;
    
    
    
    {
        int y = self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height;
        self.theaterList.frame = CGRectMake(0.0f, y, self.backEnd.bounds.size.width,self.backEnd.bounds.size.height- y);
        
        self.starList.frame = CGRectMake(0.0f, y, self.backEnd.bounds.size.width,self.backEnd.bounds.size.height- y);
    }
    
    self.headerMovieDetail.frame = CGRectMake(0,0, self.view.frame.size.width,self.headerHeight);
    
    self.headerMovieDetail.clipsToBounds = NO;
    [self.headerMovieDetail chargerAvecMovie:self.movie];
    
    
    {
        int margin = 10;
        int width = 30;
        int height = 30;
        
        {
            int x = self.navigationController.navigationBar.frame.size.width - width - margin;
            int y = 0;
            self.icBandeAnnonce.frame = CGRectMake(x, y, width, height);
            self.icBandeAnnonce.center = CGPointMake(self.icBandeAnnonce.center.x, self.navigationController.navigationBar.frame.size.height/2);
        }
        
        {
            int x = self.navigationController.navigationBar.frame.size.width - self.icBandeAnnonce.frame.size.width - width - margin - 5;
            int y = 0;
            self.icPictures.frame = CGRectMake(x, y, width, height);
            self.icPictures.center = CGPointMake(self.icPictures.center.x, self.navigationController.navigationBar.frame.size.height/2);
        }
    }
    
}

#pragma mark - OCLoadMoviesTaskDelegate


-(void)onMovieFullRecu:(LoadMovieFullTask*)task movie:(Movie *)movie{
    [super enablePan:true];
    self.movie = movie;
    
    self.contentMovie = [[MovieDetailContent alloc]initWithFrame:CGRectZero];
    self.contentMovie.height = -1;
    self.contentMovie.delegate = self;
    [self.contentMovie setBackgroundColor:[UIColor clearColor]];
    [self.frontEnd addSubview:self.contentMovie];
    
    self.contentMovie.frame = CGRectMake(0,self.headerHeight, self.view.frame.size.width,self.view.frame.size.height-self.headerHeight);
    
    [self.contentMovie chargerAvecMovie:self.movie];
    
    self.headerMovieDetail.movie = movie;
    [self.headerMovieDetail chargerVersionsDisponibles];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (MOVIE_HEADER_ANIMATION + 0.5) * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self openAndCloseMenu];
        self.viewPager.movie = movie;
        [self.viewPager reloadData];
        
        self.viewPagerBa.ba = [movie.bandesAnnonces mutableCopy];
        self.viewPagerBa.movie = movie;
        
        [self.viewPagerBa reloadData];
        
        [self ajouterImage];
    });
    
}

-(void)lancerVueTheatreDetailMovie
{
    OCTheaterDetailMovieController *controller = [[OCTheaterDetailMovieController alloc] init];
    controller.movie = self.movie;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)onMovieFullRecuVide:(LoadMovieFullTask*)task{
    
}

-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    if (afficher) {
        self.headerMovieDetail.loader.hidden = NO;
        [self.headerMovieDetail.loader animer];
    }else{
        self.headerMovieDetail.loader.hidden = YES;
        [self.headerMovieDetail.loader stopAnimating];
    }
}

#pragma mark - onPanDelegate

-(void)onPanJaquette:(UIPanGestureRecognizer *)onPan{
    [self onPan:onPan];
}

#pragma mark - MovideDetailContentDelegate

-(void)horairesClicked
{
    [self findLocation];
}

-(void)memberClicked:(PersonFull *)person{
    OCStarDetailViewController * controller = [[OCStarDetailViewController alloc]init];
    controller.star = person;
    [self setTitle:self.movie.title];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)findLocation
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [locationManager requestAlwaysAuthorization];
    
    [locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    [locationManager stopUpdatingLocation];
    
    if(locations.count > 0){
        CLLocation* newLocation = locations[0];
        
        OCAppDelegate* app = APP_DELEGATE;
        app.myLocationGPS =newLocation;
        
        NSString *lat = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
        NSString *lng = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        
        if(DEBUG){
            lat = @"48.85568";
            lng = @"2.339401";
        }
        
        [[[OCLoadShowTimesTask alloc] initWithDelegate:self] execute:@[self.movie, lat, lng]];
    }
    
}

-(void)onLoadShowTimesTaskCallBack:(NSArray*)result
{
    self.theaterList.hidden = NO;
    [self.theaterList loadTheaters:result];
    
    [self openAndCloseMenu];
    
    self.viewPagerBa.hidden = YES;
    self.viewPager.hidden = YES;
    self.starList.hidden = YES;
}

-(void)didSelectTheater:(Theater*)theater
{
    OCTheaterDetailMovieController* controller =  [[OCTheaterDetailMovieController alloc] init];
    controller.theater = theater;
    controller.movie = self.movie;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)onBandeAnnonceClicked:(Media*)bandeAnnonce
{
    Rendition* r = bandeAnnonce.rendition[0];
    
    MPMoviePlayerViewController* player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:r.href]];
    player.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    [self presentMoviePlayerViewControllerAnimated:player];
}

-(void)onMoreStarClicked
{
    self.starList.movie = self.movie;
    self.starList.hidden = NO;
    [self.starList.tableView reloadData];
    
    [self openAndCloseMenu];
}

-(void)onStarClicked:(CastMember *)member
{
    PersonFull * person = [[PersonFull alloc]init];
    person.activity = member.person.activity;
    person.picture = member.picture;
    Name * name = [[Name alloc]init];
    name.family = member.person.name;
    name.given = @"";
    person.name = name;
    person.code = member.person.code;
    person.statistics = member.person.statistics;
    
    [self memberClicked:person];
    
}

@end
