//
// Created by florent champigny on 23/12/14.
// Copyright (c) 2014 bdc. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "OCMovieViewPager.h"
#import "Person.h"


@implementation OCMovieViewPager

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    self.urlImages = [self.movie getUrlImages];
    return self.urlImages.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(view == nil){
        view = [[UIImageView alloc] initWithFrame:self.swipeView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    UIImageView *image = (UIImageView*)view;
    NSString *urlImage = self.urlImages[index];
    image.backgroundColor = [UIColor blackColor];
    image.contentMode = UIViewContentModeScaleAspectFit;
    if(urlImage!=nil)
        [image sd_setImageWithURL:[[NSURL alloc] initWithString:urlImage]];
    
    return view;
}

@end