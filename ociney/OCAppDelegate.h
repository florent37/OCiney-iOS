//
//  OCAppDelegate.h
//  ociney
//
//  Created by Florent Champigny on 21/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "RechercheTask.h"
#import <CoreLocation/CoreLocation.h>

#define APP_DELEGATE (OCAppDelegate*)[UIApplication sharedApplication].delegate

@interface OCAppDelegate : UIResponder <UIApplicationDelegate,UISearchBarDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (atomic, strong) UINavigationController *navigationController;

@property (atomic, strong) ECSlidingViewController *slidingViewController;

@property (nonatomic, strong) UIButton *menu;

@property (strong, nonatomic) NSMutableArray * moviesList;


-(void)lancerVueFilm:(NSArray *) movieList;

-(void) changeTopViewController:(NSInteger)tagController;

-(void)toggleLeftDrawer;

@property (strong, nonatomic) UIWindow *frontWindow;
@property (strong, nonatomic) UIWindow *backWindow;

-(void)cacherMenu:(BOOL)cacher;
-(void)cacherBoutonRecherche:(BOOL)cacher;
-(void)cacherSearchBar:(BOOL)cacher;
-(void)fermerSearchBar:(BOOL)fermer andCacherRecherche:(BOOL)cacher;

// Search Bar
@property (nonatomic, strong) UIButton *search;
@property (nonatomic, assign) BOOL openSearch;
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) NSString * placeholderSearch;

@property (strong, nonatomic) CLLocation *myLocationGPS;

@property (strong,nonatomic) RechercheTask * task;
-(void)searchBarMore:(NSInteger)page;

-(void)displayDetailScreen:(BOOL)secondScreen;

@end

