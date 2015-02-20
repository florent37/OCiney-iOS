//
// Created by florent champigny on 23/12/14.
// Copyright (c) 2014 bdc. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "OCStarViewPager.h"
#import "Person.h"


@implementation OCStarViewPager

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    if(self.star != nil && self.star.media != nil){
        return self.star.media.count;
    }
    return 0;
}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(view == nil){
        view = [[UIImageView alloc] initWithFrame:self.swipeView.bounds];
        view.backgroundColor = [UIColor whiteColor];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    
    UIImageView *image = (UIImageView*)view;
    Media *media = self.star.media[index];
    image.backgroundColor = [UIColor blackColor];
    image.contentMode = UIViewContentModeScaleAspectFit;
    if(media.thumbnail.href!=nil)
        [image sd_setImageWithURL:[[NSURL alloc] initWithString:media.thumbnail.href]];

    return view;
}

@end