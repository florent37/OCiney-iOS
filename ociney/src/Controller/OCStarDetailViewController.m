//
//  OCStarDetailViewController.m
//  ociney
//
//  Created by florent champigny on 21/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCStarDetailViewController.h"
#import "Color+Hex.h"
#import "UIImage+Blur.h"
#import "MovieDetailController.h"
#import "AnalyticsKit.h"

@implementation OCStarDetailViewController

- (void)viewDidLoad {
    
    [AnalyticsKit logScreen:@"StarDetail"];
    
    self.url = self.star.picture.href;

    [super viewDidLoad];
    self.headerHeight = HEADER_STAR_HEIGHT;
    
    
    self.starDetail = [[StarDetail alloc] init];
    self.starDetail.delegate = self;
    [self.frontEnd addSubview:self.starDetail];
    
    self.headerStarDetail = [[HeaderStarDetail alloc] initWithFrame:CGRectZero];
    self.headerStarDetail.star = self.star;
    [self.frontEnd addSubview:self.headerStarDetail];
    
    self.viewPager = [[OCStarViewPager alloc] init];
    [self.backEnd addSubview:self.viewPager];
    
    self.grid = [[OCStarFilmoGrid alloc] init];
    self.grid.hidden = YES;
    self.grid.delegate = self;
    [self.backEnd addSubview:self.grid];
    
    [self ajouterImage];
    
    NSString *code = [NSString stringWithFormat:@"%d",self.star.code];
    
    [[[OCLoadPersonTask alloc] initWithDelegate:self] execute:@[code]];
    
    

    
    {
        self.icPictures  = [UIButton new];
        self.icFilmo  = [UIButton new];
        
        [self.icPictures setImage:[UIImage imageNamed:@"ic_picture2_30"] forState:UIControlStateNormal];
        [self.icPictures setImage:[UIImage imageNamed:@"ic_picture2_80"] forState:UIControlStateHighlighted];
        [self.icPictures setImage:[UIImage imageNamed:@"ic_picture2_80"] forState:UIControlStateSelected];
        
        [self.icPictures addTarget:self action:@selector(icPicturesTap) forControlEvents:UIControlEventTouchUpInside];
        
        [self.icFilmo setImage:[UIImage imageNamed:@"ic_filmo_30"] forState:UIControlStateNormal];
        [self.icFilmo setImage:[UIImage imageNamed:@"ic_filmo_80"] forState:UIControlStateHighlighted];
        [self.icFilmo setImage:[UIImage imageNamed:@"ic_filmo_80"] forState:UIControlStateSelected];
        
        [self.icFilmo addTarget:self action:@selector(icFilmoTap) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    self.icPictures.selected = YES;
}

-(void)icPicturesTap{
    self.icFilmo.selected = NO;
     self.icPictures.selected = YES;
    
    self.grid.hidden = YES;
    self.viewPager.hidden = NO;
}

-(void)icFilmoTap{
    self.icFilmo.selected = YES;
    self.icPictures.selected = NO;
    
    self.grid.hidden = NO;
    self.viewPager.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.headerStarDetail.frame = CGRectMake(0, 0, self.view.bounds.size.width, HEADER_STAR_HEIGHT);
    
    self.viewPager.frame = self.backEnd.bounds;
    {
        int x = self.view.bounds.origin.x;
        int y = MAX(64,self.view.bounds.origin.x + self.navigationController.navigationBar.frame.size.height + self.navigationController.navigationBar.frame.origin.y);
        int width = self.view.bounds.size.width;
        int height = self.view.bounds.size.height-y;
        
        self.grid.frame = CGRectMake(x,y,width,height);
        self.grid.backgroundColor = [UIColor colorFromHexString:BACKGROUND_WHITE_GRAY];
    }
    
    self.starDetail.frame = CGRectMake(0, HEADER_STAR_HEIGHT, self.view.bounds.size.width, self.frontEnd.bounds.size.height - self.headerStarDetail.frame.size.height);
    
    {
        int margin = 10;
        int width = 30;
        int height = 30;
        
        {
            int x = self.navigationController.navigationBar.frame.size.width - width - margin;
            int y = 0;
            self.icFilmo.frame = CGRectMake(x, y, width, height);
            self.icFilmo.center = CGPointMake(self.icFilmo.center.x, self.navigationController.navigationBar.frame.size.height/2);
        }
        
        {
            int x = self.navigationController.navigationBar.frame.size.width - self.icFilmo.frame.size.width - width - margin;
            int y = 0;
            self.icPictures.frame = CGRectMake(x, y, width, height);
            self.icPictures.center = CGPointMake(self.icPictures.center.x, self.navigationController.navigationBar.frame.size.height/2);
        }
        
        [self.navigationController.navigationBar.viewForBaselineLayout addSubview:self.icPictures];
        [self.navigationController.navigationBar.viewForBaselineLayout addSubview:self.icFilmo];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self.icFilmo removeFromSuperview];
    [self.icPictures removeFromSuperview];
}

#pragma mark - OCLoadPersonTaskDelegate

-(void)onPersonRecu:(OCLoadPersonTask*)task person:(PersonFull *)person
{
    self.star = person;
    [super enablePan:true];
    
    [self.headerStarDetail loadStarFull:(PersonFull*)self.star];
    [self.starDetail loadStarFull:(PersonFull*)self.star];
    [self.grid loadStarFull:(PersonFull*)self.star];

    self.viewPager.star = person;
    [self.viewPager reloadData];
    
    [self openAndCloseMenu];
}

-(void)erreurReseau:(AsyncTask*)task
{
    
}

-(void)afficherChargement:(AsyncTask*)task afficher:(BOOL)afficher
{
    if (afficher) {
        self.headerStarDetail.loader.alpha = 1;
        self.headerStarDetail.loader.hidden = NO;
        [self.headerStarDetail.loader animer];
    }else{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.headerStarDetail.loader.alpha = 0;
        } completion:^(BOOL finished) {
            self.headerStarDetail.loader.hidden = YES;
            [self.headerStarDetail.loader stopAnimating];
        }];
    }
}

#pragma mark - StarDetailDelegate

-(void)onMovieClicked:(NSInteger)index
{
    MovieDetailController *controller = [MovieDetailController new];
    controller.movie = ((Participation*)self.star.participation[index]).movie;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)onMoreMovieClicked
{
    [self icFilmoTap];
    [super openAndCloseMenu];
}

-(void)onPhotoClicked:(NSInteger)index
{
    [self.viewPager.swipeView scrollToPage:index-1 duration:0];
    [self onMorePhotoClicked];
}

-(void)onMorePhotoClicked
{
    [self icPicturesTap];
    [super openAndCloseMenu];
}

@end
