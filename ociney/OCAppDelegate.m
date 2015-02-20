//
//  OCAppDelegate.m
//  ociney
//
//  Created by Florent Champigny on 21/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCSplashViewController.h"
#import "LeftViewController.h"
#import "OCListMovieViewController.h"
#import "OCStarListController.h"
#import "Constantes.h"
#import "GTAppMenuController.h"
#import "MovieDetailController.h"
#import "Color+Hex.h"
#import "ListSallesController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "OCTheaterDetailMovieController.h"
#import "OCCreditsViewController.h"
#import "AnalyticsKit.h"
#import "AnalyticsKitGoogleAnalyticsProvider.h"

@interface OCAppDelegate(){
    NSInteger tagControllerActive;
}
@end

@implementation OCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [Fabric with:@[CrashlyticsKit]];
    
    NSString *googleTrackId = @"UA-58169759-1";

#if DEBUG
    googleTrackId = @"";
#endif
    
    AnalyticsKitGoogleAnalyticsProvider *google = [[AnalyticsKitGoogleAnalyticsProvider alloc] initWithTrackingID:googleTrackId];
    [AnalyticsKit initializeLoggers:@[google]];
    
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:
                                 [[OCSplashViewController alloc] init]];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
    
    self.myLocationGPS = nil;
    
    return YES;
}

-(void)lancerVueFilm:(NSArray *) movieList{
    
    tagControllerActive = FILMS_MENU;
    
    LeftViewController *underLeftViewController  = [[LeftViewController alloc] init];
    OCListMovieViewController * topController = [[OCListMovieViewController alloc]init];
    
    [topController.array addObjectsFromArray:movieList];
    self.moviesList = [topController.array mutableCopy];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:topController];
    
    UINavigationController* leftNav = [[UINavigationController alloc] initWithRootViewController:underLeftViewController];
    leftNav.navigationBarHidden = NO;
    
    
    UIColor* barColor = [UIColor blackColor];
    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    leftNav.navigationBar.barTintColor = barColor;
    leftNav.navigationBar.opaque = YES;
    leftNav.navigationBar.translucent = NO;
    
    UIView* nav = self.navigationController.navigationBar.viewForBaselineLayout;
    
    {
        self.menu  = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
        
        self.menu.center = CGPointMake(self.menu.center.x, nav.center.y);
        [self.menu setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        self.menu.alpha = 0.8;
        self.menu.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [nav addSubview:self.menu];
        
        [self.menu addTarget:self action:@selector(toggleLeftDrawer) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    {
        
        self.search  = [[UIButton alloc] initWithFrame:CGRectMake(nav.frame.size.width - 35, 0, 25, 25)];
        self.search.center = CGPointMake(self.search.center.x, nav.center.y);
        
        [self.search setImage:[UIImage imageNamed:@"ic_action_search.png"] forState:UIControlStateNormal];
        self.search.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [nav addSubview:self.search];
        
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(nav.frame.size.width - 35, 0, 0, nav.frame.size.height)];
        
        self.searchBar.delegate = self;
        self.searchBar.showsCancelButton = YES;
        self.searchBar.barStyle = UIBarStyleBlack;
        
        [nav addSubview:self.searchBar];
        
        
        self.openSearch = NO;
        
        [self.search addTarget:self action:@selector(editSearch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // configure under left view controller
    underLeftViewController.edgesForExtendedLayout = UIRectEdgeTop | UIRectEdgeBottom | UIRectEdgeLeft; // don't go under the top view
    
    
    // configure sliding view controller
    self.slidingViewController = [ECSlidingViewController slidingWithTopViewController:self.navigationController];
    self.slidingViewController.underLeftViewController  = leftNav;
    
    
    self.slidingViewController.anchorLeftPeekAmount = 60.0;
    self.slidingViewController.anchorRightPeekAmount = 60.0;
    
    
    self.slidingViewController.defaultTransitionDuration = 0.18;
    
    // enable swiping on the top view
    [self enableSwipeGesture:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.slidingViewController;
    [self.window makeKeyAndVisible];
}

-(void)displayDetailScreen:(BOOL)secondScreen{
    if(secondScreen)
    { //detail
        [self enableSwipeGesture:NO];
        [self cacherMenu:YES];
    }else
    { //menu
        [self enableSwipeGesture:YES];
        [self cacherMenu:NO];
    }
}

-(void)enableSwipeGesture:(BOOL)enable
{
    if(enable){
        // enable swiping on the top view
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }else{
        // enable swiping on the top view
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
    }
}

-(void) editSearch:(UIButton *)sender
{
    
    [self fermerSearchBar:NO andCacherRecherche:NO];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
    [self fermerSearchBar:YES andCacherRecherche:NO];
    [self.searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.task execute:@[searchBar.text]];
    [self.searchBar resignFirstResponder];
}


-(void)searchBarMore:(NSInteger)page{
    [self.task execute:@[self.searchBar.text,@(page)]];
    
}

- (void)toggleLeftDrawer{
    if ([self.slidingViewController currentTopViewPosition] == ECSlidingViewControllerTopViewPositionAnchoredRight)
    {
        [self.slidingViewController resetTopViewAnimated:YES];
    }else{
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
}

-(NSString *) titleWithTag{
    
    NSString * title;
    
    switch (tagControllerActive) {
        case FILMS_MENU:
        {
            title = @"Films";
            
        }
            break;
            
        case STARTS_MENU:
        {
            title = @"Stars";
        }
            break;
            
        case SALLES_MENU:
        {
            title = @"Salles";
        }
            break;
            
        default:
        {
            title = NSLocalizedString(@"app_name", nil);
            
        }
            break;
    }
    
    return title;
}

-(void) changeTopViewController:(NSInteger)tagController{
    
    if(tagController != tagControllerActive){
        
        UIViewController * topController = nil;
        tagControllerActive = tagController;
        
        
        switch (tagController) {
            case FILMS_MENU:
            {
                
                topController = [[OCListMovieViewController alloc]init];
                ((OCListMovieViewController *)topController).array = [self.moviesList mutableCopy];
                
                break;
            }
                
            case STARTS_MENU:
            {
                
                topController = [[OCStarListController alloc]init];

                
            }
                break;
                
            case SALLES_MENU:
            {
                
                topController = [[ListSallesController alloc]init];
                
                
            }
                break;
                
            case FAVORIS_MENU:
            {
                
                topController = [[OCListMovieViewController alloc]init];
                
                
            }
                break;
                
            case CREDITS_MENU:
            {
                
                topController = [[OCCreditsViewController alloc]init];
                
                
            }
                break;
                
            default:
            {
                topController = [[OCListMovieViewController alloc]init];                
            }
                break;
        }
        
        
        [topController setTitle:[self titleWithTag]];
        
        [self.navigationController setViewControllers: [NSArray arrayWithObject: topController]
                                             animated: NO];
        
        [self.slidingViewController resetTopViewAnimated:YES];
        
        //[self cacherMenu:YES];
        [self.searchBar setText:@""];
        
        
        if([topController isKindOfClass:[OCCreditsViewController class]])
            [self fermerSearchBar:YES andCacherRecherche:YES];
        else
            [self fermerSearchBar:YES andCacherRecherche:NO];
        [self enableSwipeGesture:YES];
    }
    
}


-(void)cacherMenu:(BOOL)cacher{
    
    self.menu.hidden = cacher;
}

-(void)cacherBoutonRecherche:(BOOL)cacher{
    
    [UIView animateWithDuration:0.1 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(void) {
        self.search.hidden = cacher;
    }completion:^(BOOL finished) {
        [self.searchBar resignFirstResponder];
    } ];
}

-(void)cacherSearchBar:(BOOL)cacher{
    self.searchBar.hidden = cacher;
    [self.searchBar resignFirstResponder];
}

-(void)fermerSearchBar:(BOOL)fermer andCacherRecherche:(BOOL)cacher{
    
    if(fermer){
        
        [self.navigationController.topViewController setTitle:[self titleWithTag]];
        
        
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(void) {
            
            self.searchBar.frame = CGRectMake(65, self.searchBar.frame.origin.y, 0, self.searchBar.frame.size.height);
            
        } completion:^(BOOL finished) {
            self.search.hidden = cacher;
            [self.searchBar resignFirstResponder];
        } ];
        
        [self.task.cancelDelegate onCancelSearch];
        
    }else{
        
        [self.searchBar setPlaceholder:self.placeholderSearch];
        
        [self.navigationController.topViewController setTitle:@""];
        
        self.search.hidden = YES;
        
        [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^(void) {
            
            self.searchBar.frame = CGRectMake(65, self.searchBar.frame.origin.y, 250, self.searchBar.frame.size.height);
            [self.searchBar becomeFirstResponder];
            
        } completion:^(BOOL finished) {} ];
    }
    
}

@end
