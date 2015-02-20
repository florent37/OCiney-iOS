//
//  TheaterDetailMovieBackground.m
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "TheaterDetailMovieBackground.h"
#import "Color+Hex.h"
#import "Media.h"
#import "UIImageView+WebCache.m"

@implementation TheaterDetailMovieBackground
{
    BOOL first;
    Media* bandeAnnonce;
    UITapGestureRecognizer* tap;
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
    if(first){
        first = NO;
        
        [self creer];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)loadMovie:(Movie *)movie
{
    self.movie = movie;
    bandeAnnonce = self.movie.bandesAnnonces[0];
    
    if(bandeAnnonce != nil){
        [self.ecran sd_setImageWithURL:[NSURL URLWithString:bandeAnnonce.thumbnail.href]];
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBandeAnnonceClicked)];
        [self.ecran addGestureRecognizer:tap];
    }
}


-(void)creer
{
    bandeAnnonce = self.movie.bandesAnnonces[0];
    
    self.userInteractionEnabled = YES;
    
    self.ecran = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.ecran.backgroundColor = [UIColor colorFromHexString:@"#c1c1c1"];
    self.ecran.alpha = 0.3;
    self.ecran.userInteractionEnabled = YES;

    self.rideauBasGauche = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curtain_sub_left"]];
    self.rideauBasDroite = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curtain_sub_right"]];
    self.rideauHautGauche = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curtain_left"]];
    self.rideauHautDroite = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"curtain_right"]];
    self.sieges = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seats"]];
    
    self.ecran.contentMode = UIViewContentModeScaleAspectFill;
    self.rideauBasGauche.contentMode = UIViewContentModeScaleAspectFill;
    self.rideauBasDroite.contentMode = UIViewContentModeScaleAspectFill;
    self.rideauHautGauche.contentMode = UIViewContentModeScaleAspectFill;
    self.rideauHautDroite.contentMode = UIViewContentModeScaleAspectFill;
    self.sieges.contentMode = UIViewContentModeScaleAspectFill;
    
    self.ecran.clipsToBounds = YES;
    self.rideauBasGauche.clipsToBounds = YES;
    self.rideauBasDroite.clipsToBounds = YES;
    self.rideauHautGauche.clipsToBounds = YES;
    self.rideauHautDroite.clipsToBounds = YES;
    self.sieges.clipsToBounds = YES;
    
    if(bandeAnnonce != nil)
        [self.ecran sd_setImageWithURL:[NSURL URLWithString:bandeAnnonce.thumbnail.href]];
    
    [self addSubview:self.ecran];
    [self addSubview:self.rideauBasGauche];
    [self addSubview:self.rideauBasDroite];
    [self addSubview:self.rideauHautGauche];
    [self addSubview:self.rideauHautDroite];
    [self addSubview:self.sieges];
}

-(void)remplir
{
    {
        int margin = 15;
        
        NSInteger x = 0;
        NSInteger y = margin;
        NSInteger width = self.bounds.size.width - margin*2;
        NSInteger height = 160;
        
        self.ecran.frame = CGRectMake(x, y, width, height);
        self.ecran.center = CGPointMake(self.bounds.size.width/2, self.ecran.center.y);
    }
    
    { //rideaux
        NSInteger rideauHauteur = self.ecran.frame.size.height + self.ecran.frame.origin.x*3;
        {
            NSInteger rideauLargeur = self.bounds.size.width/2;
            
            {
                NSInteger x = 0;
                NSInteger y = 0;
                NSInteger width = rideauLargeur;
                NSInteger height = rideauHauteur;
                
                self.rideauBasGauche.frame = CGRectMake(x, y, width, height);
            }
            
            {
                NSInteger y = 0;
                NSInteger width = rideauLargeur;
                NSInteger height = rideauHauteur;
                NSInteger x = self.bounds.size.width - width;
                
                self.rideauBasDroite.frame = CGRectMake(x, y, width, height);
            }
        }
        
        {
            NSInteger rideauLargeur = self.bounds.size.width/3;
            
            {
                NSInteger x = 0;
                NSInteger y = 0;
                NSInteger width = rideauLargeur;
                NSInteger height = rideauHauteur;
                
                self.rideauHautGauche.frame = CGRectMake(x, y, width, height);
            }
            
            {
                NSInteger y = 0;
                NSInteger width = rideauLargeur;
                NSInteger height = rideauHauteur;
                NSInteger x = self.bounds.size.width - width;
                
                self.rideauHautDroite.frame = CGRectMake(x, y, width, height);
            }
        }
    }
    
    { //sièges
        NSInteger x = 0;
        NSInteger y = self.ecran.frame.origin.y + self.ecran.frame.size.height + 20;
        NSInteger width = self.bounds.size.width;
        NSInteger height = 100;
        
        self.sieges.frame = CGRectMake(x, y, width, height);
    }
    
}

-(void)animerOuverture
{
    [UIView animateWithDuration:2 delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.rideauBasGauche.transform = CGAffineTransformMakeTranslation(-1*self.rideauBasGauche.frame.size.width, 0);
        self.rideauBasDroite.transform = CGAffineTransformMakeTranslation(self.rideauBasDroite.frame.size.width, 0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)onBandeAnnonceClicked
{
    [self.delegate onBandeAnnonceClicked:bandeAnnonce];
}

@end
