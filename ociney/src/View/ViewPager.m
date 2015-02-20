//
//  ViewPager.m
//  ociney
//
//  Created by florent champigny on 24/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "ViewPager.h"

@implementation ViewPager
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

-(void)reloadData
{
    [self.swipeView reloadData];
}

- (void)layoutSubviews {
    if(first)
    {
        [self creer];
        first = NO;
    }
}


-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.swipeView setBounds:self.bounds];
}

-(void)creer{
    self.swipeView = [[SwipeView alloc] initWithFrame:self.bounds];
    [self addSubview:self.swipeView];
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    self.swipeView.backgroundColor = [UIColor blackColor];
    // self.swipeView.bounces = NO;
    // self.swipeView.vertical = NO;
    self.swipeView.pagingEnabled = YES;
    // self.swipeView.itemsPerPage = 1;
    // self.swipeView.scrollEnabled = YES;
    // self.swipeView.wrapEnabled = YES;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

-(NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 0;
}

@end
