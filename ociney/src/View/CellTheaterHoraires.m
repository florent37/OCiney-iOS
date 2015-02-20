//
//  CellTheaterHoraires.m
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "CellTheaterHoraires.h"
#import "Color+Hex.h"
#import "Constantes.h"
#import "Horaires.h"

@implementation CellTheaterHoraires
{
    BOOL first;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        first = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [self creer];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)creer
{
    if(first){
        first = NO;
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:(self.version = [UIImageView new])];
        [self addSubview:(self.scroll = [UIScrollView new])];
        [self.scroll addSubview:(self.texte = [UILabel new])];
        
        self.scroll.backgroundColor = [UIColor clearColor];
        self.scroll.bounces = NO;
        
        self.texte.numberOfLines = 1;
        self.texte.font = [UIFont fontWithName:BOLD size:11];
        self.texte.textColor = [UIColor whiteColor];
        
        self.version.contentMode = UIViewContentModeScaleAspectFit;
    }
}

-(void)remplir
{
    self.version.frame = CGRectMake(0, 0, 18, 18);
    self.version.center = CGPointMake(self.version.center.x, self.bounds.size.height/2);
    
    self.scroll.contentSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    
    [self.texte sizeToFit];
    self.texte.frame = CGRectMake(self.version.frame.origin.x + self.version.frame.size.width, 0,  self.texte.frame.size.width, self.texte.frame.size.height);
    
    self.scroll.contentSize = CGSizeMake(self.texte.frame.size.width, self.texte.frame.size.height);
    
    {
        int x = self.version.frame.origin.x + self.version.frame.size.width;
        int width = self.bounds.size.width - x;
        self.scroll.frame = CGRectMake(x, self.version.frame.origin.y, width, self.texte.frame.size.height);
        self.scroll.center = CGPointMake(self.scroll.center.x, self.bounds.size.height/2);
    }
    
}

-(void)loadHoraires:(Horaires*)horaires
{
    [self creer];
    
    self.version.hidden = NO;
    
    if (horaires.formatEcran != nil) {
        if ([horaires.formatEcran containsString:@"3D"])
            self.version.image = [UIImage imageNamed:@"ic_version_white_3d"];
        else if ([horaires.formatEcran containsString:@"Numérique"])
            self.version.image = [UIImage imageNamed:@"ic_version_white_2d"];
        else if ([horaires.version containsString:@"Numérique"])
            self.version.image = [UIImage imageNamed:@"ic_version_white_2d"];
        else// if (![horaires.version containsString:@"Français"])
            self.version.image = [UIImage imageNamed:@"ic_version_white_vo"];
        //else
        //    self.version.hidden = YES;
    } else
        self.version.hidden = YES;
    
    NSMutableString *sb = [NSMutableString new];
    for (NSString* seance in horaires.seances){
        [sb appendString:seance];
        [sb appendString:@" "];
    }
    
    self.texte.text = sb;
    [self remplir];
}

@end
