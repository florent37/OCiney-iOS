//
//  StarDetailPhotos.m
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "StarDetailPhotos.h"

@implementation StarDetailPhotos

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self creer];
    
    return self;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self remplir];
}

-(void)creer
{
    self.layoutImage1 = [[OCStarPhoto alloc] initWithFrame:CGRectZero];
    self.layoutImage2 = [[OCStarPhoto alloc] initWithFrame:CGRectZero];
    self.layoutImage3 = [[OCStarPhoto alloc] initWithFrame:CGRectZero];
    self.layoutImage4 = [[OCStarPhoto alloc] initWithFrame:CGRectZero];
    
    [self addSubview:self.layoutImage1];
    [self addSubview:self.layoutImage2];
    [self addSubview:self.layoutImage3];
    [self addSubview:self.layoutImage4];
    
    self.layoutImage4.image.image = [UIImage imageNamed:@"plus_black"];
    self.layoutImage4.background.image = [UIImage imageNamed:@"plus_dashed_photos_black"];
    self.layoutImage4.background.alpha = 0.2;
    self.layoutImage4.image.alpha = 0.2;
    self.layoutImage4.glass.hidden = YES;
    
    [self.layoutImage1 ajouterOmbre];
    [self.layoutImage2 ajouterOmbre];
    [self.layoutImage3 ajouterOmbre];
}

-(void)remplir
{
    NSInteger width = (NSInteger) self.bounds.size.width;
    NSInteger height = (NSInteger) self.bounds.size.height;

    NSInteger p = 3;
    self.layoutImage1.padding = p;
    self.layoutImage2.padding = p;
    self.layoutImage3.padding = p;
    self.layoutImage4.padding = p;
    
    self.layoutImage1.frame = CGRectMake(0, 0, width/3, height);
    self.layoutImage2.frame = CGRectMake(width/3, 0, width*2/3, height/2);
    self.layoutImage3.frame = CGRectMake(width/3, height/2, width/3, height/2);
    self.layoutImage4.frame = CGRectMake(width*2/3, height/2, width/3, height/2);
    
    self.layoutImage4.image.frame = CGRectMake(0, 0, self.layoutImage4.bounds.size.width/3, self.layoutImage4.bounds.size.height/3);
    self.layoutImage4.image.center = CGPointMake(self.layoutImage4.bounds.size.width/2+3, self.layoutImage4.bounds.size.height/2+1);
    
    self.layoutImage1.userInteractionEnabled = YES;
    self.layoutImage2.userInteractionEnabled = YES;
    self.layoutImage3.userInteractionEnabled = YES;
    self.layoutImage4.userInteractionEnabled = YES;
    
    [self.layoutImage1 addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1)]
    ];
    
    [self.layoutImage2 addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2)]
     ];
    
    [self.layoutImage3 addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3)]
     ];
    
    [self.layoutImage4 addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMore)]
     ];
}

-(void)vider
{
    self.layoutImage1 = nil;
    self.layoutImage2 = nil;
    self.layoutImage3 = nil;
    self.layoutImage4 = nil;
}

-(void)load:(PersonFull*)personFull
{
    NSArray *medias = personFull.media;
    
    if(medias.count > 0){
        Media *m1 = [personFull.media objectAtIndex:0];
        [self.layoutImage1 loadImageUrl:m1.thumbnail.href];
        
        if(medias.count > 1){
            Media *m2 = [personFull.media objectAtIndex:1];
            [self.layoutImage2 loadImageUrl:m2.thumbnail.href];
            
            if(medias.count > 2){
                Media *m3 = [personFull.media objectAtIndex:2];
                [self.layoutImage3 loadImageUrl:m3.thumbnail.href];
            }
        }
    }
    
     [self vider];
}

-(void)tap1
{
    [self.delegate onPhotoClicked:1];
}

-(void)tap2
{
    [self.delegate onPhotoClicked:2];

}

-(void)tap3
{
    [self.delegate onPhotoClicked:3];

}

-(void)tapMore
{
    [self.delegate onMorePhotoClicked];

}

@end
