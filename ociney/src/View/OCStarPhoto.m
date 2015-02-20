//
//  OCStarPhoto.m
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "OCStarPhoto.h"
#import "UIImageView+WebCache.h"

@implementation OCStarPhoto

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.bounds = CGRectMake(self.padding, self.padding, self.frame.size.width-self.padding*2, self.frame.size.height-self.padding*2);
    
    self.background.frame = self.bounds;
    
    self.image.frame = self.bounds;
    self.glass.frame = self.bounds;
    
    
    [self vider];
    
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.clipsToBounds = YES;
    
    self.background = [UIImageView new];
    self.background.contentMode = UIViewContentModeScaleAspectFit;
    self.background.clipsToBounds = YES;
    [self addSubview:self.background];
    
    self.image = [UIImageView new];
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    self.image.clipsToBounds = YES;
    [self addSubview:self.image];
    
    self.glass = [UIImageView new];
    self.glass.contentMode = UIViewContentModeScaleAspectFill;
    self.glass.clipsToBounds = YES;
    self.glass.image = [UIImage imageNamed:@"filmo_reflet"];
    [self addSubview:self.glass];
    
    self.background.alpha = 0.5;
    self.image.alpha = 0.8;
    self.glass.alpha = 0.8;
    
    return self;
}

-(void)vider
{
    //self.image = nil;
    self.background = nil;
    self.glass = nil;
}

-(void)ajouterOmbre{
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
}

-(void)loadImageUrl:(NSString*)url
{
    [self.image sd_setImageWithURL:[[NSURL alloc] initWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = nil;
    }];
}

@end
