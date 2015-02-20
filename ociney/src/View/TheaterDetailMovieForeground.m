//
//  TheaterDetailMovieForeground.m
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "TheaterDetailMovieForeground.h"

@implementation TheaterDetailMovieForeground
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
    if(first){
        first = NO;
        [self creer];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)creer
{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.backgroundView = [UIView new]];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    
    
    [self addSubview:(self.swipeView = [[SwipeView alloc] initWithFrame:self.bounds])];
    
    self.swipeView.pagingEnabled = YES;
    self.swipeView.dataSource = self;
    self.swipeView.delegate = self;
    self.swipeView.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:(self.header = [[HeaderMovieDetail alloc] initWithFrame:CGRectZero])];
    self.header.backgroundColor = [UIColor clearColor];
    
    self.header.loader.hidden = NO;
    [self.header.loader animer];

}

-(void)remplir
{
    self.header.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, MOVIE_HEADER_HEIGHT);
    [self.header chargerAvecMovie:self.movie];
    
    {
        NSInteger y = self.header.frame.origin.y + self.header.frame.size.height + 15;
        NSInteger height = self.bounds.size.height - y;
        
        self.swipeView.frame = CGRectMake(self.bounds.origin.x, y, self.bounds.size.width, height);
        [self.swipeView reloadData];
    }
    
    {
        NSInteger y = self.header.frame.origin.y + self.header.frame.size.height;
        NSInteger height = self.bounds.size.height - y;
        
        self.backgroundView.frame = CGRectMake(self.bounds.origin.x, y, self.bounds.size.width, height);
    }
    
}

#pragma mark - SwipeViewDataSource

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.theater.horairesSemaineJours.count;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(view == nil){
        view = [[TheaterDetailMoviePageHoraires alloc] initWithFrame:self.swipeView.bounds];
        view.backgroundColor = [UIColor clearColor];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    TheaterDetailMoviePageHoraires *v = (TheaterDetailMoviePageHoraires*)view;
    
    NSString *jour = self.theater.horairesSemaineJours[index];
    NSArray *horaires = self.theater.horairesSemaine[jour];
    
    [v loadJour:jour andHoraires:horaires];
    
    return view;
}

#pragma mark - SwipeViewDelegate

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

@end
