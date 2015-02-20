//
//  OCMovieDelegates.h
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#ifndef ociney_OCMovieDelegates_h
#define ociney_OCMovieDelegates_h

#import "Media.h"
#import "Person.h"
#import "CastMember.h"

@protocol OCMovieBandeAnnonceSliderDelegate
-(void)onBandeAnnonceClicked:(Media*)bandeAnnonce;
@end

@protocol OCMovieStarListDelegate
-(void)onStarClicked:(CastMember*)star;
-(void)onMoreStarClicked;
@end


#endif
