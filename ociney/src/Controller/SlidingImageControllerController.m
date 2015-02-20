//
//  SlidingImageControllerController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "SlidingImageControllerController.h"
#import "TTUIScrollViewSlidingPages.h"
#import "UIImageView+WebCache.h"

@interface SlidingImageControllerController ()<TTSlidingPagesDataSource>

@end

@implementation SlidingImageControllerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.opaque = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    UIView * vueFond = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
    
    [vueFond setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:vueFond];
    

        
    
}

-(void)ajouterImages:(NSArray *)urlImage{
    self.urlImages = [[NSArray alloc]initWithArray:urlImage];
    
    TTScrollSlidingPagesController *slider = [[TTScrollSlidingPagesController alloc] init];
    slider.titleScrollerHidden = YES;
    slider.disableUIPageControl = YES;
    slider.zoomOutAnimationDisabled = YES;
    slider.dataSource = self; /*the current view controller (self) conforms to the TTSlidingPagesDataSource protocol)*/
    slider.view.frame = self.view.frame; //I'm setting up the view to be fullscreen in the current view
    [self.view addSubview:slider.view];
    [self addChildViewController:slider];
}

-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 3;
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index{
    
    
    UIViewController * viewController = [[UIViewController alloc]init];
    viewController.view.frame = self.frame;
    
    UIImageView * image = [[UIImageView alloc]initWithFrame:self.frame];
    [image sd_setImageWithURL:[NSURL URLWithString:[self.urlImages objectAtIndex:index]]];

    [viewController.view addSubview:image];
    
    
    return [[TTSlidingPage alloc] initWithContentViewController:viewController];
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    //all other pages just use a simple text header
    title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"A page"]; //in reality you would have the correct header text for your page number given by "index"
    
    return title;
}


@end



