//
//  OCMovieBandeAnnonceSliderElement.m
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "OCMovieBandeAnnonceSliderElement.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Color+Hex.h"
#import "Constantes.h"

@implementation OCMovieBandeAnnonceSliderElement
{
    BOOL firstCreer;
    BOOL firstPlacer;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        firstPlacer = YES;
        firstCreer = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(firstCreer){
        firstCreer = NO;
        [self creer];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)creer
{
    self.backgroundColor = [UIColor blackColor];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.clipsToBounds =YES;
    
    [self addSubview:(self.warfog = [UIView new])];
    self.warfog.backgroundColor = [UIColor colorFromHexString:BLACK50];
    
    [self addSubview:(self.image = [UIImageView new])];
    self.image.backgroundColor = [UIColor clearColor];
    self.image.contentMode = UIViewContentModeScaleAspectFill;
    
    [self addSubview:(self.titre = [UILabel new])];
    self.titre.numberOfLines = 2;
    self.titre.textAlignment = NSTextAlignmentCenter;
    self.titre.textColor = [UIColor whiteColor];
    self.titre.font = [UIFont fontWithName:THIN size:15];
    
    [self addSubview:(self.filtre = [UIView new])];
    [self.filtre setBackgroundColor:[UIColor colorFromHexString:BLACK50]];
    
    [self addSubview:(self.play = [UIImageView new])];
    
    
    [self addSubview:(self.backgroundTopBorder = [UIView new])];
    self.backgroundTopBorder.backgroundColor =[UIColor colorFromHexString:BLACK50];
    
    [self addSubview:(self.backgroundBottomBorder = [UIView new])];
    self.backgroundBottomBorder.backgroundColor = [UIColor colorFromHexString:BLACK50];

}

-(void)placer
{
    if(firstPlacer){
        firstPlacer = NO;
        self.warfog.frame =CGRectMake(0, 0,self.frame.size.width, 250);
        self.warfog.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        self.image.frame = CGRectMake(0, 0, self.frame.size.width-10, 150);
        self.image.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        self.titre.frame = CGRectMake(0, 30, 150, 150);
        self.titre.center = CGPointMake(self.frame.size.width/2,self.titre.center.y);
        
        self.filtre.frame= self.bounds;
        
        self.play.frame = CGRectMake(0, 0, 70, 70);
        self.play.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        self.play.image = [UIImage imageNamed:@"play.png"];
        
        int pelliculeHeight = 45;
        
        self.backgroundTopBorder.frame = CGRectMake(0, self.warfog.frame.origin.y, self.frame.size.width, pelliculeHeight);
        self.backgroundBottomBorder.frame = CGRectMake(0, self.warfog.frame.origin.y + self.warfog.frame.size.height - pelliculeHeight, self.frame.size.width, pelliculeHeight);
        

        
        for(int i=0;i<self.backgroundTopBorder.frame.size.width/pelliculeHeight;i++){
            UIImageView * imagePellicule = [[UIImageView alloc]initWithFrame:CGRectMake(pelliculeHeight *i, 0,pelliculeHeight, pelliculeHeight)];
            imagePellicule.image = [UIImage imageNamed:@"pellicule.png"];
            imagePellicule.contentMode = UIViewContentModeScaleAspectFill;
            [self.backgroundTopBorder addSubview:imagePellicule];
        }
        
        
        for(int i=0;i<self.backgroundBottomBorder.frame.size.width/pelliculeHeight;i++){
            UIImageView * imagePellicule = [[UIImageView alloc]initWithFrame:CGRectMake(pelliculeHeight *i, 0,pelliculeHeight, pelliculeHeight)];
            imagePellicule.image = [UIImage imageNamed:@"pellicule.png"];
            imagePellicule.contentMode = UIViewContentModeScaleAspectFill;
            [self.backgroundBottomBorder addSubview:imagePellicule];
        }
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)]];
    }
    
}

-(void)remplir
{
    [self placer];
}

-(void)tapped
{
    [self.delegate onBandeAnnonceClicked:self.media];
}

@end
