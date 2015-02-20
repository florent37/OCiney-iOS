//
//  OCFilmoGridLayout.m
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCFilmoGridLayout.h"

@implementation OCFilmoGridLayout

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self creer];
    }
    return self;
}

-(void)sizeToFit
{
    [super sizeToFit];
    [self remplir];
}

-(void)creer
{
    self.filmoArray = [NSMutableArray array];
    
    for(NSInteger i=0;i<8;++i){
        OCFilmoElement* filmo = [[OCFilmoElement alloc] initWithFrame:CGRectZero];
        
        [self addSubview:filmo];
        [self.filmoArray addObject:filmo];
    }
}

-(void)remplir
{
    NSInteger nbPerLine = 4;
    NSInteger nbElement = self.filmoArray.count;
    NSInteger nbLine = nbElement / nbPerLine;
    
    NSInteger width = (NSInteger) self.bounds.size.width;
    NSInteger minWidth = FILMO_ELEMENT_WIDTH * nbPerLine;
    width = MAX(width,minWidth);
    NSInteger widthPerElement = width/nbPerLine;
    
    NSInteger heightPerElement = FILMO_ELEMENT_HEIGHT;
    
    NSInteger height = heightPerElement * nbLine;
    
    for(NSInteger i=0;i<nbElement;++i){
        
        NSInteger col = i%nbPerLine;
        NSInteger row = i<nbPerLine ? 0 : 1;
        
        OCFilmoElement* filmo = self.filmoArray[(NSUInteger) i];
        filmo.delegate = self.delegate;
        
        if(i == nbElement-1){
            filmo.more = YES;
        }else{
            Participation *participation = nil;
            if(i < self.star.participation.count)
                participation = [self.star.participation objectAtIndex:(NSUInteger) i];
            filmo.participation = participation;
            filmo.index = i;
        }
        [filmo sizeToFit];
        
        NSInteger centerX = widthPerElement*col + widthPerElement/2;
        
        NSInteger centerY = heightPerElement*row + heightPerElement/2;
        
        filmo.center = CGPointMake(centerX, centerY);
    }
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
}



@end
