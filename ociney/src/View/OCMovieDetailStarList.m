//
//  OCMovieDetailStarList.m
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "OCMovieDetailStarList.h"
#import "OCCastMember.h"

#define CELL_TAG @"OCMovieDetailStarList"
#define VIEW_TAG 10

#define CELL_HEIGHT 80

@implementation OCMovieDetailStarList
{
    BOOL first;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        first = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self creer];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)creer
{
    if(first){
        first = NO;
        
        self.backgroundColor = [UIColor blackColor];

        [self addSubview:self.tableView = [UITableView new]];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.backgroundColor = [UIColor blackColor];
        
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_TAG];
    }
}

-(void)remplir
{
    self.tableView.frame = CGRectMake(0, 0, self.bounds.size.width-50, self.bounds.size.height);
    self.tableView.center = CGPointMake(self.bounds.size.width/2, self.tableView.center.y);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.movie != nil && self.movie.castMember!= nil)
        return self.movie.castMember.count + 2;
    else
        return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_TAG];
    
    OCCastMember* castView = (OCCastMember*)[cell viewWithTag:VIEW_TAG];
    if(castView == nil)
    {
        castView = [OCCastMember new];
        castView.tag = VIEW_TAG;
        castView.delegate = self.delegate;
        [cell addSubview:castView];
        
        cell.backgroundColor = [UIColor clearColor];
        castView.backgroundColor = [UIColor blackColor];
        
        castView.frame = CGRectMake(0, 0, tableView.frame.size.width, CELL_HEIGHT);
    }
    
    if(indexPath.row<self.movie.castMember.count)
        [castView loadMember:self.movie.castMember[indexPath.row]];
    else
        [castView loadMember:nil];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT + 5;
}

@end
