//
//  OCViewController.m
//  ociney
//
//  Created by Florent Champigny on 21/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCSplashViewController.h"
#import "Color+Hex.h"
#import "OCListMovieViewController.h"
#import "OCAppDelegate.h"

@interface OCSplashViewController (){
    UIView * fondStripe;
    UILabel * descriptif;
    UIView * splash_logo;
    UIImageView * ic_glass;
    UIImageView * ic_text_ociney;
    UIImageView * ic_drawer_film;
    OCAppDelegate * appDelegate;
}

@end

@implementation OCSplashViewController

#define DEGREES_IN_RADIANS(x) (M_PI * x / 180.0);


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorFromHexString:GRAY]];

    appDelegate = ((OCAppDelegate*)[[UIApplication sharedApplication] delegate]);

    fondStripe = [[UIView alloc] initWithFrame:CGRectZero];
    fondStripe.alpha = 0.2f;
    [fondStripe setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"splash_motif_stripes_black.png"]]];
    [self.view addSubview:fondStripe];
    
    descriptif = [[UILabel alloc]initWithFrame:CGRectZero];
    [descriptif setTextColor:[UIColor whiteColor]];
    descriptif.textAlignment = NSTextAlignmentCenter;
    //[UIFont fontWithName:@"Roboto-Light" size:13]
    descriptif.font = [UIFont systemFontOfSize:12];

    [descriptif setText:@"FILMS | HORAIRES | CRITIQUES | CASTING"];
    
    [self.view addSubview:descriptif];
    
    splash_logo = [[UIView alloc]initWithFrame:CGRectZero];
    
    ic_glass = [[UIImageView alloc]initWithFrame:CGRectZero];
    ic_glass.image = [UIImage imageNamed:@"ic_glass_reflect_color_big.png"];
    
    [splash_logo addSubview:ic_glass];
    
    
    ic_text_ociney = [[UIImageView alloc]initWithFrame:CGRectZero];
    ic_text_ociney.image = [UIImage imageNamed:@"ic_txt_ociney.png"];
    
    [splash_logo addSubview:ic_text_ociney];
    
    [self.view addSubview:splash_logo];
    
    
    ic_drawer_film = [[UIImageView alloc]initWithFrame:CGRectZero];
    ic_drawer_film.image = [UIImage imageNamed:@"ic_drawer_films.png"];
    
    [self.view addSubview:ic_drawer_film];
    
    
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [fullRotation setFromValue:[NSNumber numberWithFloat:0]];
    [fullRotation setToValue:[NSNumber numberWithFloat:((2*M_PI))]];
    fullRotation.speed = 5.0f;
    fullRotation.duration = 5.5;
    fullRotation.repeatCount = 1;
    
    fullRotation.repeatCount = HUGE_VALF;
    
    [[ic_drawer_film layer] addAnimation:fullRotation forKey:@"transform.rotation"];
    
    self.task = [[OCLoadMoviesTask alloc]initWithDelegate:self];
    [self.task execute:@[@"nowshowing",@"small",@"toprank",@20,@1]];
}



-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:NO];

    fondStripe.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    descriptif.frame = CGRectMake(0, 30, self.view.frame.size.width, 80);
    
    // On met la vue au milieu
    splash_logo.frame = CGRectMake(0, 0, self.view.frame.size.width, 135);
    splash_logo.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    
    ic_glass.frame = CGRectMake(0, 0,160,95);
    ic_glass.center = CGPointMake(splash_logo.center.x, ic_glass.center.y);
    
    
    ic_text_ociney.frame = CGRectMake(0, 95, 150, 40);
    ic_text_ociney.center = CGPointMake(splash_logo.center.x, ic_text_ociney.center.y);
    
    
    ic_drawer_film.frame = CGRectMake(0,self.view.frame.size.height - 100, 54, 54);
    ic_drawer_film.center = CGPointMake(self.view.center.x, ic_drawer_film.center.y);
    
}

#pragma mark - OCLoadMoviesTaskDelegate


-(void)onMoviesListRecu:(OCLoadMoviesTask*)task moviesList:(NSArray*)moviesList{
    [appDelegate lancerVueFilm:moviesList];

}

-(void)onMoviesListResultatVide:(OCLoadMoviesTask*)task{
    
}

-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    
}

@end
