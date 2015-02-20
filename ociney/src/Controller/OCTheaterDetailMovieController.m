//
//  OCTheaterDetailMovieController.m
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCTheaterDetailMovieController.h"
@import MediaPlayer;
#import "AnalyticsKit.h"

@implementation OCTheaterDetailMovieController
{
    BOOL first;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AnalyticsKit logScreen:@"TheaterDetailMovie"];
    
    first = YES;
    [self creer];
    
    LoadMovieFullTask *task = [[LoadMovieFullTask alloc] initWithDelegate:self];
    
    [task execute:@[
                    [NSString stringWithFormat:@"%i",self.movie.code]
                    ]
     ];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self remplir];    
}

-(void)creer
{
    self.view.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor blackColor];
    self.background = [[TheaterDetailMovieBackground alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.background];
    
    self.foreground = [[TheaterDetailMovieForeground alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.foreground];
    
    self.background.movie = self.movie;
    self.background.delegate = self;
    self.foreground.movie = self.movie;
    self.foreground.theater = self.theater;
    
    self.navigationController.navigationBar.opaque = NO;
    self.navigationController.navigationBar.translucent = YES;
    
}

-(void)remplir
{
    {
        int y = self.navigationController.navigationBar.frame.origin.y+self.navigationController.navigationBar.frame.size.height;
        self.background.frame = CGRectMake(0.0f, y, self.view.bounds.size.width,self.view.bounds.size.height- y);
    }
    
    if(first){
        NSInteger x = 0;
        NSInteger width = self.view.bounds.size.width;
        NSInteger height = 350;
        NSInteger y = self.view.bounds.size.height - MOVIE_HEADER_HEIGHT;
        
        self.foreground.frame = CGRectMake(x, y, width, height);
        
        
    }else{
            CGRect foregroundFrame = self.foreground.frame;
            foregroundFrame.origin.y = self.view.bounds.size.height - foregroundFrame.size.height;
            self.foreground.frame = foregroundFrame;
    }
}

-(void)animerOuverture
{
    if(first){
        first = NO;
        
        [self.background animerOuverture];
        
        CGRect foregroundFrame = self.foreground.frame;
        foregroundFrame.origin.y = self.view.bounds.size.height - foregroundFrame.size.height;
        
        [UIView animateWithDuration:0.4
                              delay:3
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.foreground.header.loader.alpha = 0;
                             self.foreground.frame = foregroundFrame;
                         } completion:^(BOOL finished) {
                             [self.foreground.header.loader stopAnimating];
                         }];
    }
}

-(void)onBandeAnnonceClicked:(Media *)bandeAnnonce
{
    Rendition* r = bandeAnnonce.rendition[0];
    
    MPMoviePlayerViewController* player = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:r.href]];
    player.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    [self presentMoviePlayerViewControllerAnimated:player];
}

-(void)onMovieFullRecu:(LoadMovieFullTask*)task movie:(Movie *)movie
{
    self.movie = movie;
    [self.background loadMovie:self.movie];
    [self animerOuverture];
}
-(void)onMovieFullRecuVide:(LoadMovieFullTask*)task
{
}

-(void)erreurReseau:(AsyncTask*)task
{
    
}
-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    
}

@end
