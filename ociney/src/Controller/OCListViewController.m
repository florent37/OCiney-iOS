//
//  OCListControllerViewController.m
//  ociney
//
//  Created by florent champigny on 25/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCListViewController.h"
#import "OCAppDelegate.h"
#import "Color+Hex.h"

@interface OCListViewController (){
    OCAppDelegate* delegate;
}

@end

@implementation OCListViewController

-(id)init
{
    if(self = [super init]){
        self.page = 1;
        self.loadMore = YES;
        
        self.array = [NSMutableArray array];
        self.apparitions = [NSMutableArray array];
        
        delegate = (OCAppDelegate*) [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // On alloue la table view on se met en delegate
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.emptyView = [[OCEmptyView alloc]initWithFrame:CGRectZero];
    self.emptyView.hidden = YES;
    
    [self.view addSubview:self.emptyView];
    
    {
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.colors = @[(id) [[UIColor colorFromHexString:@"#333333ff"] CGColor], (id) [[UIColor colorFromHexString:@"#555555ff"] CGColor]];
        [self.tableView.layer insertSublayer:self.gradient atIndex:0];
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.tableView.frame = self.view.bounds;
    
    self.emptyView.frame = self.view.bounds;
    [self.emptyView positionner];
    
    self.gradient.frame = self.tableView.bounds;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)onClick{
    [self.appDelegate cacherMenu:YES];
    
    [self.appDelegate cacherSearchBar:YES];
    
    if(!self.searchOn)
        [self.appDelegate fermerSearchBar:YES andCacherRecherche:YES];
    
    [self.appDelegate displayDetailScreen:YES];
    
    [self setTitle:self.titleView];
}

-(void) afficherEmptyView:(BOOL)afficher{
    self.emptyView.hidden = !afficher;
    self.tableView.hidden = afficher;
}
@end
