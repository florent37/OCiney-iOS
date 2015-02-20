//
//  OCRechercheSearchBarController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 23/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCRechercheSearchBarController.h"

@interface OCRechercheSearchBarController ()

@end

@implementation OCRechercheSearchBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (OCAppDelegate*)[[UIApplication sharedApplication] delegate];
    self.searchOn = NO;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.appDelegate displayDetailScreen:NO];
    
    if(!self.searchOn){
        [self setTitle:self.titleView];
        [self.appDelegate cacherBoutonRecherche:NO];
        [self.appDelegate cacherSearchBar:NO];
        
    }else{
        [self setTitle:@""];
        
        [self.appDelegate cacherSearchBar:NO];
    }
    
    [self.appDelegate cacherMenu:NO];
}

@end
