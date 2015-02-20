//
//  TheaterDetailMoviePageHoraires.m
//  ociney
//
//  Created by florent champigny on 30/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "TheaterDetailMoviePageHoraires.h"
#import "Color+Hex.h"
#import "Constantes.h"
#import "CellTheaterHoraires.h"

@implementation TheaterDetailMoviePageHoraires
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
    if(first){
        first = NO;
        [self creer];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self remplir];
}

-(void)creer
{   
    
    [self addSubview:(self.dateLabel = [UILabel new])];
    [self addSubview:(self.prevDate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_prev"]])];
    [self addSubview:(self.nextDate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_next"]])];
    [self addSubview:(self.divier = [UIView new])];
    
    self.dateLabel.textColor = [UIColor colorFromHexString:@"#37474f"];
    self.dateLabel.font = [UIFont fontWithName:LIGHT size:20];
    
    self.divier.backgroundColor = [UIColor colorFromHexString:WHITE30];
    
    self.prevDate.alpha = 0.3;
    self.nextDate.alpha = 0.3;
    self.prevDate.contentMode = UIViewContentModeScaleAspectFit;
    self.nextDate.contentMode = UIViewContentModeScaleAspectFit;
    
    self.horaires.backgroundColor = [UIColor clearColor];
    
    [self addSubview:(self.horaires = [UIView new])];
}

-(void)remplir
{
    {
        self.dateLabel.text = self.jour;
        
        NSInteger x = 0;
        NSInteger y = 0;

        self.dateLabel.text = [self.dateLabel.text uppercaseString];
        [self.dateLabel sizeToFit];
        self.dateLabel.frame = CGRectMake(x, y, self.dateLabel.frame.size.width, self.dateLabel.frame.size.height);
        self.dateLabel.center = CGPointMake(self.bounds.size.width/2, self.dateLabel.center.y);
    }
    
    {
        NSInteger x = self.dateLabel.frame.origin.x - 25;
        NSInteger y = 0;
        NSInteger width = 20;
        NSInteger height = 20;
        
        self.prevDate.frame = CGRectMake(x, y, width, height);
        self.prevDate.center = CGPointMake(self.prevDate.center.x, self.dateLabel.center.y);
    }
    
    {
        NSInteger x = self.dateLabel.frame.origin.x + self.dateLabel.frame.size.width + 10;
        NSInteger y = 0;
        NSInteger width = 20;
        NSInteger height = 20;
        
        self.nextDate.frame = CGRectMake(x, y, width, height);
        self.nextDate.center = CGPointMake(self.nextDate.center.x, self.dateLabel.center.y);
    }
    
    {
        NSInteger marginTop = 10;
        
        NSInteger x = 0;
        NSInteger y = self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height + marginTop;
        NSInteger width = 240;
        NSInteger height = 1;
        
        self.divier.frame = CGRectMake(x, y, width, height);
        self.divier.center = CGPointMake(self.bounds.size.width/2, self.divier.center.y);
    }
    
    
    {
        NSInteger marginTop = 10;
        
        NSInteger x = 0;
        NSInteger y = self.divier.frame.origin.y + self.divier.frame.size.height + marginTop;
        NSInteger width = 200;
        NSInteger height = self.bounds.size.height - y;
        
        self.horaires.frame = CGRectMake(x, y, width, height);
        self.horaires.center = CGPointMake(self.bounds.size.width/2, self.horaires.center.y);
        
        for (UIView *v in self.horaires.subviews) {
            [v removeFromSuperview];
        }
        
        NSInteger globalY = 0;
        for(int i =0;i<self.arrayHoraires.count;++i)
        {
            CellTheaterHoraires *line = [[CellTheaterHoraires alloc] initWithFrame:CGRectZero];
            
            line.frame = CGRectMake(0, globalY, self.horaires.bounds.size.width, 20);
            globalY += line.frame.size.height;
             
            [line loadHoraires:self.arrayHoraires[i]];
            
            [self.horaires addSubview:line];
        }
    }
}

-(void)loadJour:(NSString*)jour andHoraires:(NSArray*)horaires
{
    self.jour = jour;
    self.arrayHoraires = horaires;
    [self remplir];
}

@end
