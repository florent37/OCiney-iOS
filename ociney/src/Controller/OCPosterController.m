//
//  OCPosterController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 05/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCPosterController.h"

@interface OCPosterController ()

@end

@implementation OCPosterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.posterView = [[PosterView alloc]initWithFrame:CGRectZero];
    
    [self.view addSubview:self.posterView];
    
    self.posterView.userInteractionEnabled = YES;
    [self.posterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.posterView.frame = self.frameContent;
    
    [self.posterView chargerAvecMovie:self.movie];
}

-(void)tap
{
    [self.delegate onPosterSelected:self.movie];
}

@end
