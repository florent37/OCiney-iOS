//
//  OCMovieBandeAnnonceSlider.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 31/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCMovieBandeAnnonceSlider.h"
#import "OCMovieBandeAnnonceSliderElement.h"
#import <SDWebImage/UIImageView+WebCache.h>

float scrollParalax(SwipeView* swipeView, UIView *view)
{
    int width = view.frame.size.width;
    float offset = swipeView.scrollOffset;
    offset = offset - (int)offset;
    
    CGFloat s = width* offset * 0.30;
    
    NSLog(@"%f",s);

    return s;
}

@implementation OCMovieBandeAnnonceSlider

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return self.ba.count;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if(view == nil){
        view = [[OCMovieBandeAnnonceSliderElement alloc] initWithFrame:self.swipeView.bounds];
    }
    
    OCMovieBandeAnnonceSliderElement* v = (OCMovieBandeAnnonceSliderElement*)view;
    v.delegate = self.delegate;
    
    Media *ba = self.ba[index];
    v.media = ba;
    
    NSString * t = ba.title;
    t = [t stringByReplacingOccurrencesOfString:self.movie.title withString:@""];
    t = [t stringByReplacingOccurrencesOfString:self.movie.originalTitle withString:@""];
    t = [t stringByReplacingOccurrencesOfString:@"\"\"" withString:@""];
    t = [t stringByReplacingOccurrencesOfString:@":" withString:@""];
    t = [t stringByTrimmingCharactersInSet:
             [NSCharacterSet whitespaceCharacterSet]];
    
    //replace(movie.getTitle(), "").replace(movie.getOriginalTitle(), "").replace("\"\"", "").replace(":", "").trim()
    if ([t hasPrefix:@"-"]) {
        //do your stuff
        t = [t substringFromIndex:1];
        t = [t stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    }
    
    v.titre.text = t;
    
    if(ba!=nil && ba.thumbnail != nil && ba.thumbnail.href != nil)
        [v.image sd_setImageWithURL:[[NSURL alloc] initWithString:ba.thumbnail.href]];

    return view;
}

@end
