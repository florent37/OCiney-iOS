//
//  OCStarFilmoGrid.m
//  ociney
//
//  Created by florent champigny on 29/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCStarFilmoGrid.h"
#import "OCFilmoElement.h"
#import "Color+Hex.h"
#import "Constantes.h"

#define CELL_ID @"OCStarFilmoGridCell"

@implementation OCStarFilmoGrid

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self creer];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self remplir];
}

-(void)creer
{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    [flow setItemSize:CGSizeMake(FILMO_ELEMENT_WIDTH, FILMO_ELEMENT_HEIGHT)];
    [flow setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[OCFilmoElement class] forCellWithReuseIdentifier:CELL_ID];
    
    [self addSubview:self.collectionView];
    
    self.backgroundColor = [UIColor colorFromHexString:BACKGROUND_WHITE_GRAY];
    self.collectionView.backgroundColor = [UIColor colorFromHexString:BACKGROUND_WHITE_GRAY];
}

-(void)remplir
{
    {
        int margin = 30;
        
        int x = 0;
        int y = 0;
        int width = self.bounds.size.width - margin*2;
        int height = self.bounds.size.height;
        self.collectionView.frame = CGRectMake(x, y, width, height);
        
        self.collectionView.center = CGPointMake(self.bounds.size.width/2, self.collectionView.center.y);
    }
}

-(void)loadStarFull:(PersonFull*)starFull
{
    self.star = starFull;
    [self remplir];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.star == nil)
        return 0;
    else
        return self.star.participation.count + 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    
    Participation *participation = nil;
    if(indexPath.row < self.star.participation.count)
        participation = [self.star.participation objectAtIndex:(NSUInteger) indexPath.row];
    ((OCFilmoElement*)cell).participation = participation;
    ((OCFilmoElement*)cell).delegate = self.delegate;
    ((OCFilmoElement*)cell).index = indexPath.row;
    
    [cell sizeToFit];
    
    return cell;
}

@end
