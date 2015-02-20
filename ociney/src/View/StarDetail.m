//
//  StarDetail.m
//  ociney
//
//  Created by florent champigny on 22/12/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "StarDetail.h"
#import "Color+Hex.h"
#import "DateUtils.h"

@implementation StarDetail
{
    NSInteger globalY;
    BOOL firstRemplir;
}

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame])
    {
        firstRemplir = YES;
    }
    return self;
}

-(void)creer
{
    self.backgroundColor = [UIColor colorFromHexString:BACKGROUND_WHITE_GRAY];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.bounces = NO;
    [self addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.contentView];
    
    {
        self.labelDateNaissance = [[UILabel alloc] initWithFrame:CGRectZero];
        self.labelDateNaissance.textColor = [UIColor colorFromHexString:BLACK50];
        self.labelDateNaissance.font = [UIFont fontWithName:LIGHT size:12];
        self.labelDateNaissance.text = NSLocalizedString(@"date_naissance", nil);
        [self.contentView addSubview:self.labelDateNaissance];
    }
    {
        self.labelLieuNaissance = [[UILabel alloc] initWithFrame:CGRectZero];
        self.labelLieuNaissance.textColor = [UIColor colorFromHexString:BLACK50];
        self.labelLieuNaissance.font = [UIFont fontWithName:LIGHT size:12];
        self.labelLieuNaissance.text = NSLocalizedString(@"lieu_naissance", nil);
        [self.contentView addSubview:self.labelLieuNaissance];
    }
    {
        self.labelActivites = [[UILabel alloc] initWithFrame:CGRectZero];
        self.labelActivites.textColor = [UIColor colorFromHexString:BLACK50];
        self.labelActivites.font = [UIFont fontWithName:LIGHT size:12];
        self.labelActivites.text = NSLocalizedString(@"activités", nil);
        [self.contentView addSubview:self.labelActivites];
    }
    
    {
        self.labelDateNaissanceValeur = [[UILabel alloc] initWithFrame:CGRectZero];
        self.labelDateNaissanceValeur.textColor = [UIColor blackColor];
        self.labelDateNaissanceValeur.textAlignment = NSTextAlignmentRight;
        self.labelDateNaissanceValeur.font = [UIFont fontWithName:BOLD size:11];
        [self.contentView addSubview:self.labelDateNaissanceValeur];
    }
    {
        self.labelLieuNaissanceValeur = [[UILabel alloc] initWithFrame:CGRectZero];
        self.labelLieuNaissanceValeur.textColor = [UIColor blackColor];
        self.labelLieuNaissanceValeur.textAlignment = NSTextAlignmentRight;
        self.labelLieuNaissanceValeur.lineBreakMode = NSLineBreakByWordWrapping;
        self.labelLieuNaissanceValeur.numberOfLines = 0;
        self.labelLieuNaissanceValeur.font = [UIFont fontWithName:BOLD size:11];
        [self.contentView addSubview:self.labelLieuNaissanceValeur];
    }
    {
        self.labelActivitesValeur = [[UILabel alloc] initWithFrame:CGRectZero];
        self.labelActivitesValeur.textColor = [UIColor blackColor];
        self.labelActivitesValeur.textAlignment = NSTextAlignmentRight;
        self.labelActivitesValeur.lineBreakMode = NSLineBreakByWordWrapping;
        self.labelActivitesValeur.numberOfLines = 0;
        self.labelActivitesValeur.font = [UIFont fontWithName:BOLD size:11];
        [self.contentView addSubview:self.labelActivitesValeur];
    }
    
    {
        self.biographie = [[UILabel alloc] initWithFrame:CGRectZero];
        self.biographie.backgroundColor = [UIColor clearColor];
        self.biographie.textColor = [UIColor colorFromHexString:BLACK90];
        self.biographie.textAlignment = NSTextAlignmentJustified;
        self.biographie.font = [UIFont fontWithName:REGULAR size:12];
        self.biographie.numberOfLines = 0;
        self.biographie.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:self.biographie];
    }
    
    {
        self.separateurBiographie = [[UILabel alloc] initWithFrame:CGRectZero];
        self.separateurBiographie.textColor = [UIColor colorFromHexString:BLACK20];
        self.separateurBiographie.textAlignment = NSTextAlignmentCenter;
        self.separateurBiographie.font = [UIFont fontWithName:BLACK size:25];
        self.separateurBiographie.text = [NSLocalizedString(@"biographie", nil) uppercaseString];
        [self.contentView addSubview:self.separateurBiographie];
    }
    
    {
        self.filmographieLayout = [[OCFilmoGridLayout alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.filmographieLayout];
    }
    
    {
        self.separateurFilmographie = [[UILabel alloc] initWithFrame:CGRectZero];
        self.separateurFilmographie.textColor = [UIColor colorFromHexString:BLACK20];
        self.separateurFilmographie.textAlignment = NSTextAlignmentCenter;
        self.separateurFilmographie.font = [UIFont fontWithName:BLACK size:25];
        self.separateurFilmographie.text = [NSLocalizedString(@"filmographie", nil) uppercaseString];
        [self.contentView addSubview:self.separateurFilmographie];
    }
    
    {
        self.photosLayout = [[StarDetailPhotos alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.photosLayout];
    }
    
    {
        self.separateurPhotos = [[UILabel alloc] initWithFrame:CGRectZero];
        self.separateurPhotos.textColor = [UIColor colorFromHexString:BLACK20];
        self.separateurPhotos.textAlignment = NSTextAlignmentCenter;
        self.separateurPhotos.font = [UIFont fontWithName:BLACK size:25];
        self.separateurPhotos.text = [NSLocalizedString(@"photos", nil) uppercaseString];
        [self.contentView addSubview:self.separateurPhotos];
    }
    
}

-(void)remplir
{
    if(firstRemplir)
    {
        if(self.labelDateNaissance == nil)
            [self creer];
        
        globalY = 0;
        NSInteger globalX = 20;
        
        NSInteger margins = 15;
        
        if(self.star != nil){
            
            {
                NSInteger marginTop = margins + 5;
                NSInteger y = globalY+marginTop;
                NSInteger x = globalX;
                NSInteger width = 100;
                NSInteger height = 0;
                self.labelDateNaissance.frame = CGRectMake(x, y, width, height);
                [self.labelDateNaissance sizeToFit];
                
                globalY += self.labelDateNaissance.frame.size.height+marginTop;
            }
            {
                int marginRight = 20;
                NSInteger y = (NSInteger) self.labelDateNaissance.frame.origin.y;
                NSInteger x = (NSInteger) (self.labelDateNaissance.frame.origin.x + self.labelDateNaissance.frame.size.width);
                NSInteger width = (NSInteger) (self.frame.size.width - x - marginRight);
                NSInteger height = 0;
                self.labelDateNaissanceValeur.frame = CGRectMake(x, y, width, height);
                self.labelDateNaissanceValeur.text = [DateUtils formatBithDate:self.star.birthDate];
                [self.labelDateNaissanceValeur sizeToFit];
                self.labelDateNaissanceValeur.frame = CGRectMake(x, y, width, self.labelDateNaissanceValeur.frame.size.height);
            }
            
            
            {
                NSInteger marginTop = margins;
                NSInteger y = globalY+marginTop;
                NSInteger x = globalX;
                NSInteger width = 100;
                NSInteger height = 0;
                self.labelLieuNaissance.frame = CGRectMake(x, y, width, height);
                [self.labelLieuNaissance sizeToFit];
                
            }
            {
                int marginRight = 20;
                NSInteger y = (NSInteger) self.labelLieuNaissance.frame.origin.y;
                NSInteger x = (NSInteger) (self.labelLieuNaissance.frame.origin.x + self.labelLieuNaissance.frame.size.width);
                NSInteger width = (NSInteger) (self.frame.size.width - x - marginRight);
                NSInteger height = 0;
                self.labelLieuNaissanceValeur.frame = CGRectMake(x, y, width, height);
                self.labelLieuNaissanceValeur.text = self.star.birthPlace;
                [self.labelLieuNaissanceValeur sizeToFit];
                self.labelLieuNaissanceValeur.frame = CGRectMake(x, y, width, self.labelLieuNaissanceValeur.frame.size.height);
                
                globalY =
                MAX(
                    self.labelLieuNaissance.frame.size.height+self.labelLieuNaissance.frame.origin.y,
                    self.labelLieuNaissanceValeur.frame.size.height+self.labelLieuNaissanceValeur.frame.origin.y
                    )
               ;

            }
            
            {
                NSInteger marginTop = margins;
                NSInteger y = globalY+marginTop;
                NSInteger x = globalX;
                NSInteger width = 100;
                NSInteger height = 0;
                self.labelActivites.frame = CGRectMake(x, y, width, height);
                [self.labelActivites sizeToFit];
                
            }
            {
                int marginRight = 20;
                NSInteger y = (NSInteger) self.labelActivites.frame.origin.y;
                NSInteger x = (NSInteger) (self.labelActivites.frame.origin.x + self.labelActivites.frame.size.width);
                NSInteger width = (NSInteger) (self.frame.size.width - x - marginRight);
                NSInteger height = 0;
                self.labelActivitesValeur.frame = CGRectMake(x, y, width, height);
                self.labelActivitesValeur.text = [self.star getActivities];
                [self.labelActivitesValeur sizeToFit];
                self.labelActivitesValeur.frame = CGRectMake(x, y, width, self.labelActivitesValeur.frame.size.height);
                
                globalY += MAX(self.labelActivites.frame.size.height,self.labelActivitesValeur.frame.size.height);
                
            }
            
            globalY += margins*2;
            
            if(self.star.biography != nil){
                {
                    NSInteger y = globalY;
                    NSInteger x = 0; //center
                    NSInteger width = 150;
                    NSInteger height = 0;
                    self.separateurBiographie.frame = CGRectMake(x, y, width, height);
                    [self.separateurBiographie sizeToFit];
                    self.separateurBiographie.frame = CGRectMake(x, y, width, self.separateurBiographie.frame.size.height);
                    
                    self.separateurBiographie.center = CGPointMake(self.frame.size.width/2, self.separateurBiographie.center.y);
                    globalY = (NSInteger) (self.separateurBiographie.frame.origin.y + self.separateurBiographie.frame.size.height);
                }
            }
            
            globalY += margins;
            
            {
                NSInteger margin = 10;
                
                NSInteger y = globalY;
                NSInteger x = 0;
                NSInteger width = (NSInteger) (self.frame.size.width - globalX - margin*2);
                NSInteger height = 0;
                self.biographie.frame = CGRectMake(x, y, width, height);
                
                if(self.star.biography != nil){
                    self.biographie.text = self.star.biography;
                    
                    NSString *s = self.star.biography;
                    if (s != nil) {
                        s = [s stringByReplacingOccurrencesOfString:@"<br/> <p><span></span></p> <br/>" withString:@""];
                        s = [s stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
                        s = [s stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
                        s = [s stringByReplacingOccurrencesOfString:@"<p>" withString:@"\n"];
                        s = [s stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
                        
                        
                        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\<[^>]*>" options:NSRegularExpressionCaseInsensitive error:nil];
                        s = [regex stringByReplacingMatchesInString:s options:0 range:NSMakeRange(0, [s length]) withTemplate:@""];
                    }
                    
                    NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
                    paragraphStyles.alignment                = NSTextAlignmentJustified;
                    paragraphStyles.firstLineHeadIndent      = 0.05;    // Very IMP
                    NSDictionary *attributes                 = @{NSParagraphStyleAttributeName: paragraphStyles};
                    NSAttributedString *attributedString     = [[NSAttributedString alloc] initWithString:s attributes:attributes];
                    
                    self.biographie.attributedText = attributedString;
                    
                }
                [self.biographie sizeToFit];
                self.biographie.frame = CGRectMake(x, y, width, self.biographie.frame.size.height);
                self.biographie.center = CGPointMake(self.bounds.size.width/2, self.biographie.center.y);
                
                globalY = (NSInteger) (self.biographie.frame.origin.y + self.biographie.frame.size.height);
                
            }
            
            globalY += margins;
            
            {
                NSInteger y = globalY;
                NSInteger x = 0; //center
                NSInteger width = 150;
                NSInteger height = 0;
                self.separateurFilmographie.frame = CGRectMake(x, y, width, height);
                [self.separateurFilmographie sizeToFit];
                self.separateurFilmographie.frame = CGRectMake(x, y, self.separateurFilmographie.frame.size.width, self.separateurFilmographie.frame.size.height);
                
                self.separateurFilmographie.center = CGPointMake(self.frame.size.width/2, self.separateurFilmographie.center.y);
                globalY = (NSInteger) (self.separateurFilmographie.frame.origin.y + self.separateurFilmographie.frame.size.height);
            }
            
            globalY += margins;
            
            {
                NSInteger y = globalY;
                NSInteger x = 0; //center
                NSInteger width = (NSInteger) (self.contentView.bounds.size.width - 50);
                NSInteger height = 0; //auto height
                self.filmographieLayout.frame = CGRectMake(x, y, width, height);
                
                self.filmographieLayout.star= self.star;
                [self.filmographieLayout sizeToFit];
                
                //center
                self.filmographieLayout.center = CGPointMake(self.frame.size.width/2, self.filmographieLayout.center.y);
                globalY = (NSInteger) (self.filmographieLayout.frame.origin.y + self.filmographieLayout.frame.size.height);
            }
            
            globalY += margins;
            
            {
                NSInteger y = globalY;
                NSInteger x = 0; //center
                NSInteger width = 150;
                NSInteger height = 0;
                self.separateurPhotos.frame = CGRectMake(x, y, width, height);
                [self.separateurPhotos sizeToFit];
                self.separateurPhotos.frame = CGRectMake(x, y, self.separateurPhotos.frame.size.width, self.separateurPhotos.frame.size.height);
                
                self.separateurPhotos.center = CGPointMake(self.frame.size.width/2, self.separateurPhotos.center.y);
                globalY = (NSInteger) (self.separateurPhotos.frame.origin.y + self.separateurPhotos.frame.size.height);
            }
            
            globalY += margins;
            
            {
                NSInteger y = globalY;
                NSInteger x = 0; //center
                NSInteger width = (NSInteger) (self.contentView.bounds.size.width - 50);
                NSInteger height = 200;
                self.photosLayout.frame = CGRectMake(x, y, width, height);
                [self.photosLayout load:self.star];
                
                //center
                self.photosLayout.center = CGPointMake(self.frame.size.width/2, self.photosLayout.center.y);
                globalY = (NSInteger) (self.photosLayout.frame.origin.y + self.photosLayout.frame.size.height);
                
            }
            
            globalY += 35;
            
        }
        
        self.scrollView.frame = self.bounds;
        self.contentView.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, globalY);
        self.scrollView.contentSize = CGSizeMake(self.contentView.frame.size.width, self.contentView.frame.size.height);
        
        self.filmographieLayout.delegate = self.delegate;
        self.photosLayout.delegate = self.delegate;
        
        if(self.star){
           // [self vider];
        }
    }
}

-(void)vider
{
    self.contentView = nil;
    self.scrollView = nil;
    self.labelDateNaissance = nil;
    self.labelDateNaissanceValeur = nil;
    self.labelLieuNaissance = nil;
    self.labelLieuNaissanceValeur = nil;
    self.labelActivites = nil;
    self.labelActivitesValeur = nil;
    self.separateurBiographie = nil;
    self.biographie = nil;
    self.separateurFilmographie = nil;
    self.filmographieLayout = nil;
    self.separateurPhotos = nil;
    self.photosLayout = nil;
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self remplir];
}

-(void)loadStarFull:(PersonFull*)starFull
{
    self.star = starFull;
    [self remplir];
    firstRemplir = false;
}

@end
