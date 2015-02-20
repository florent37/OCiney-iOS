//
//  OCCreditsViewController.m
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "OCCreditsViewController.h"
#import "Constantes.h"
#import "Color+Hex.h"
#import "OCAppDelegate.h"
#import "AnalyticsKit.h"

@implementation OCCreditsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [AnalyticsKit logScreen:@"Credits"];
    
    self.view.backgroundColor =[UIColor colorFromHexString:@"#333333"];
    
    [self.view addSubview:(self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_in_app_big"]])];
    self.logo.contentMode = UIViewContentModeScaleAspectFit;
    self.logo.alpha = 0.3;
    
    [self.view addSubview:(self.texte = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_txt_ociney"]])];
    self.texte.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:(self.version = [UILabel new])];
    self.version.text = VERSION_APPLICATION;
    self.version.textColor = [UIColor colorFromHexString:WHITE90];
    self.version.textAlignment = NSTextAlignmentCenter;
    self.version.font = [UIFont fontWithName:REGULAR size:12];
    
    [self.view addSubview:(self.image0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"konami_flo"]])];
    self.image0.userInteractionEnabled = YES;
    self.image0.contentMode = UIViewContentModeScaleAspectFit;
    [self.image0 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage0)]];
   
    [self.view addSubview:(self.image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"konami_kevin"]])];
    self.image1.userInteractionEnabled = YES;
    self.image1.contentMode = UIViewContentModeScaleAspectFit;
    [self.image1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage1)]];

   
    [self.view addSubview:(self.image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"konami_pooley"]])];
    self.image2.userInteractionEnabled = YES;
    self.image2.contentMode = UIViewContentModeScaleAspectFit;
    [self.image2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage2)]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [APP_DELEGATE cacherBoutonRecherche:YES];
    self.title = @"Crédits";
    
    NSInteger globalY = 30;
    NSInteger margin = 5;
    
    self.logo.frame = CGRectMake(0, globalY, 160, 50);
    self.logo.center = CGPointMake(self.view.bounds.size.width/2, self.logo.center.y);
    globalY = self.logo.frame.origin.y + self.logo.frame.size.height + 5;
    
    self.texte.frame = CGRectMake(0, globalY, 120, 40);
    self.texte.center = CGPointMake(self.view.bounds.size.width/2, self.texte.center.y);
    globalY = self.texte.frame.origin.y + self.texte.frame.size.height;

    self.version.frame = CGRectMake(0, globalY, 100, 50);
    [self.version sizeToFit];
    self.version.center = CGPointMake(self.view.bounds.size.width/2, self.version.center.y);
    globalY = self.version.frame.origin.y + self.version.frame.size.height;
    
    globalY += 30;
    
    NSInteger imageHeight = 80;
    NSInteger imageWidth = 200;
    
    self.image0.frame = CGRectMake(0, globalY, imageWidth, imageHeight);
    self.image0.center = CGPointMake(self.view.bounds.size.width/2, self.image0.center.y);
    globalY = self.image0.frame.origin.y + self.image0.frame.size.height + margin;
    
    self.image1.frame = CGRectMake(0, globalY, imageWidth, imageHeight);
    self.image1.center = CGPointMake(self.view.bounds.size.width/2, self.image1.center.y);
    globalY = self.image1.frame.origin.y + self.image1.frame.size.height + margin;
    
    self.image2.frame = CGRectMake(0, globalY, imageWidth, imageHeight);
    self.image2.center = CGPointMake(self.view.bounds.size.width/2, self.image2.center.y);
    globalY = self.image2.frame.origin.y + self.image2.frame.size.height + margin;
}

-(void)tapImage0
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/+florentchampigny"]];
}

-(void)tapImage1
{
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/+DeJesusFerreiraK%C3%A9vin"]];
}

-(void)tapImage2
{
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/+LoganBOURGOIN"]];
}

@end
