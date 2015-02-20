//
//  StarDetailDelegate.h
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#ifndef ociney_StarDetailDelegate_h
#define ociney_StarDetailDelegate_h

@protocol StarDetailDelegate

-(void)onMovieClicked:(NSInteger)index;
-(void)onMoreMovieClicked;
-(void)onPhotoClicked:(NSInteger)index;
-(void)onMorePhotoClicked;

@end

#endif
