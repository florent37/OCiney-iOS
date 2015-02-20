//
//  Poster.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 02/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "PosterView.h"
#import "Color+Hex.h"
#import "UIImageView+WebCache.h"
#import "Horaires.h"

@implementation PosterView

-(void)chargerAvecMovie:(Movie *)movie{
    self.movie = movie;
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    self.content = [[UIView alloc]initWithFrame:self.bounds];
    
    {
        
        self.contentWoodFrame = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 212, 255)];
        self.contentWoodFrame.center = CGPointMake(self.content.center.x, self.content.center.y);
        [self.contentWoodFrame setBackgroundColor:[UIColor colorFromHexString:@"#363636"]];
        
        
        {
         
            self.bg_darker_poster = [[UIView alloc]initWithFrame:CGRectMake(20, 10, self.contentWoodFrame.frame.size.width - 43 , self.contentWoodFrame.frame.size.height - 15)];
            
            
            [self.bg_darker_poster setBackgroundColor:[UIColor whiteColor]];
            
            {
                
                self.poster = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bg_darker_poster.frame.size.width - 5, self.bg_darker_poster.frame.size.height - 5)];
                
                self.poster.center = CGPointMake(self.bg_darker_poster.frame.size.width/2, self.bg_darker_poster.frame.size.height/2);
                
                [self.poster sd_setImageWithURL:[NSURL URLWithString:self.movie.poster.href]];

                self.poster.contentMode = UIViewContentModeScaleAspectFill;
                self.poster.clipsToBounds = YES;
                [self.bg_darker_poster addSubview:self.poster];
                
                
                self.folded_effect = [[UIImageView alloc]initWithFrame:self.bg_darker_poster.bounds];
                
                self.folded_effect.image = [UIImage imageNamed:@"folded_effect.png"];
                self.folded_effect.contentMode = UIViewContentModeScaleAspectFit;
                
                [self.bg_darker_poster addSubview:self.folded_effect];
            }
            
            [self.contentWoodFrame addSubview:self.bg_darker_poster];
            
            self.fondBlack = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentWoodFrame.frame.size.height - 30, self.contentWoodFrame.frame.size.width, 30)];
            
            [self.fondBlack setBackgroundColor:[UIColor blackColor]];
            [self.contentWoodFrame addSubview:self.fondBlack];
           
            // Gradient Window
            
            {
                
                self.gradient_window_view = [[UIView alloc]initWithFrame:self.contentWoodFrame.bounds];
                self.gradient_window_view.alpha = 0.2;
                [self.contentWoodFrame addSubview:self.gradient_window_view];
                
                self.gradient_window = [CAGradientLayer layer];
                self.gradient_window.frame = self.gradient_window_view.bounds;
                self.gradient_window.startPoint = CGPointMake(0.0, 0.5);
                self.gradient_window.endPoint = CGPointMake(1.0, 0.5);
                self.gradient_window.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorFromHexString:@"#83e4efff"] CGColor], nil];
                [self.gradient_window_view.layer insertSublayer:self.gradient_window atIndex:0];
                
            }
            
            
            {
                
                self.reflet_framewood = [[UIImageView alloc]initWithFrame:CGRectMake(self.contentWoodFrame.frame.size.width - 160, 0, self.contentWoodFrame.frame.size.width,self.contentWoodFrame.frame.size.height)];
                
                self.reflet_framewood.image = [UIImage imageNamed:@"reflet_framewood.png"];
                self.reflet_framewood.contentMode = UIViewContentModeScaleAspectFit;
                
                [self.contentWoodFrame addSubview:self.reflet_framewood];
            }
            
            
            
        }
        [self.content addSubview:self.contentWoodFrame];
        
        self.woodframe = [[UIImageView alloc]initWithFrame:CGRectMake(0,15, 295, 295)];
        self.woodframe.center = CGPointMake(self.content.center.x, self.content.center.y);
        
        self.woodframe.image = [UIImage imageNamed:@"wood_frame.png"];
        self.woodframe.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.woodframe];
        
        self.longShaddow = [[UIImageView alloc]initWithFrame:CGRectMake(10,15, 295, 295)];
        self.longShaddow.center = CGPointMake(self.content.center.x+10, self.content.center.y);

        
        self.longShaddow.image = [UIImage imageNamed:@"long_shadow.png"];
        self.longShaddow.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.longShaddow];
        
        self.charniereHaute = [[UIImageView alloc]initWithFrame:CGRectMake(self.woodframe.frame.origin.x + 10,self.woodframe.frame.origin.y + 30, 50, 50)];
        
        self.charniereHaute.image = [UIImage imageNamed:@"charniere.png"];
        self.charniereHaute.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.charniereHaute];
        
        
        self.charniereBasse = [[UIImageView alloc]initWithFrame:CGRectMake(self.charniereHaute.frame.origin.x,self.woodframe.frame.origin.y + self.woodframe.frame.size.height - 30 - self.charniereHaute.frame.size.height,self.charniereHaute.frame.size.width,self.charniereHaute.frame.size.height)];
        
        self.charniereBasse.image = [UIImage imageNamed:@"charniere.png"];
        self.charniereBasse.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.charniereBasse];
        
        self.serrure = [[UIImageView alloc]initWithFrame:CGRectMake(self.woodframe.frame.origin.x + self.woodframe.frame.size.width - 52,self.woodframe.frame.origin.y + self.woodframe.frame.size.height/2,10,10)];
        
        self.serrure.image = [UIImage imageNamed:@"serrure.png"];
        self.serrure.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.serrure];
        
        
        {
            self.title = [[UILabel alloc]initWithFrame:CGRectMake(70,- 15, 140, 50)];
            self.title.textAlignment = NSTextAlignmentCenter;
            NSString * titre = self.movie.title;
            [self.title setText:[titre uppercaseString]];
            [self.title setTextColor:[UIColor colorFromHexString:@"#9b7144ff"]];
            self.title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:9];
            [self.woodframe addSubview:self.title];
            
            
        }
        
        [self chargerHoraires];
        
    }
    
    
    [self addSubview:self.content];
}

-(void) chargerHoraires
{
    int y = 5;
    int heigthVue = 20;
    for (Horaires * h in self.movie.horaires) {
        if ([h isToday]) {
            
            UIView * vueHorraires = [[UIView alloc]initWithFrame:CGRectMake(0, y, self.fondBlack.frame.size.width, heigthVue)];

            
            UIImageView * version = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 20, 20)];
            version.contentMode = UIViewContentModeScaleAspectFit;

            if ([h.formatEcran containsString:@"3D"])
                version.image = [UIImage imageNamed:@"ic_version_white_3d.png"];
            else if ([h.formatEcran containsString:@"Numérique"])
                version.image = [UIImage imageNamed:@"ic_version_white_2d.png"];
            else if (![h.formatEcran containsString:@"Français"])
                version.image = [UIImage imageNamed:@"ic_version_white_vo.png"];
            else
                version.frame = CGRectZero;
            
            NSString * sb = @"";
            
            for (NSString * seance in h.seances){
                sb = [sb stringByAppendingString:seance];
                sb = [sb stringByAppendingString:@" "];

            }
            
            UILabel * texte = [[UILabel alloc]initWithFrame:CGRectMake(heigthVue + 30, 4, 200, 200)];
            texte.textColor = [UIColor colorFromHexString:WHITE90];
            //texte.center = CGPointMake(texte.center.x, version.center.y);
            texte.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10];
            [texte setText:sb];
            [texte sizeToFit];
            
            //layout.addView(vueHorraires);
            [vueHorraires addSubview:version];
            [vueHorraires addSubview:texte];
            [self.fondBlack addSubview:vueHorraires];
            //[self.fondBlack addSubview:texte];
            
            y+= heigthVue;

        }
    }
    
    self.fondBlack.frame = CGRectMake(self.fondBlack.frame.origin.x, self.fondBlack.frame.origin.y - y + heigthVue + 5, self.fondBlack.frame.size.width, y + 5);
}

@end
