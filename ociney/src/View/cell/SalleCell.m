//
//  SalleCell.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 29/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "SalleCell.h"
#import "Color+Hex.h"
#import "OCAppDelegate.h"

@implementation SalleCell
{
    BOOL notFirst;
}

- (void)awakeFromNib {
    [super layoutSubviews];
    if(!notFirst)
        [self creer];
}

-(void)creer
{
    self.content = [[UIView alloc]initWithFrame:CGRectZero];
    [self.content setBackgroundColor:[UIColor colorFromHexString:@"A0A0A0"]];
    {
        
        self.gradient_black50_black20_view = [[UIView alloc]initWithFrame:CGRectZero];
        
        {
            self.gradient_black50_black20 = [CAGradientLayer layer];
            self.gradient_black50_black20.colors = [NSArray arrayWithObjects:(id)[[UIColor colorFromHexString:BLACK50] CGColor], (id)[[UIColor colorFromHexString:BLACK20] CGColor], nil];
            [self.gradient_black50_black20_view.layer insertSublayer:self.gradient_black50_black20 atIndex:0];
        }
        
        
        [self.content addSubview:self.gradient_black50_black20_view];
        
        
        self.gradient_black100_view = [[UIView alloc]initWithFrame:CGRectZero];
        self.gradient_black100_view.alpha = 0.2f;
        {
            self.gradient_black100 = [CAGradientLayer layer];
            self.gradient_black100.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
            [self.gradient_black100_view.layer insertSublayer:self.gradient_black100 atIndex:0];
        }
        
        
        [self.content addSubview:self.gradient_black100_view];
        
        self.splash_stripes_repeat = [[UIView alloc] initWithFrame:CGRectZero];
        self.splash_stripes_repeat.alpha = 0.1f;
        [self.splash_stripes_repeat setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"splash_motif_stripes_black.png"]]];
        
        [self.content addSubview:self.splash_stripes_repeat];
        
        
        self.logo_defaut = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.logo_defaut.image = [UIImage imageNamed:@"logo_default.png"];
        self.logo_defaut.alpha = 0.1f;
        self.logo_defaut.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.content addSubview:self.logo_defaut];
        
        self.horaires = [[UIView alloc]initWithFrame:CGRectZero];
        [self.horaires setBackgroundColor:[UIColor colorFromHexString:BLACK70]];
        
        [self.content addSubview:self.horaires];
        
        self.nomCine = [[UILabel alloc]initWithFrame:CGRectZero];
        self.nomCine.font = [UIFont fontWithName:BOLD size:15];
        [self.nomCine setTextColor:[UIColor colorFromHexString:WHITE95]];
        [self.content addSubview:self.nomCine];
        
        self.adresse = [[UILabel alloc]initWithFrame:CGRectZero];
        self.adresse.font = [UIFont fontWithName:LIGHT size:11];
        [self.adresse setTextColor:[UIColor colorFromHexString:WHITE85]];
        [self.content addSubview:self.adresse];
        
        
        self.distance = [[UILabel alloc]initWithFrame:CGRectZero];
        self.distance.font = [UIFont fontWithName:LIGHT size:11];
        self.distance.textAlignment = NSTextAlignmentRight;
        [self.distance setTextColor:[UIColor colorFromHexString:WHITE90]];
        
        [self.content addSubview:self.distance];
        
        self.ic_nav = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.ic_nav.image = [UIImage imageNamed:@"ic_nav.png"];
        self.ic_nav.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.ic_nav];
        
        
        self.porte = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.porte.image = [UIImage imageNamed:@"porte.png"];
        self.porte.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.porte];
        
        self.ic_handicap = [[UIImageView alloc]initWithFrame:CGRectZero];
        self.ic_handicap.image = [UIImage imageNamed:@"ic_handicap_skew.png"];
        self.ic_handicap.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.content addSubview:self.ic_handicap];
        
    }
    
    [self.contentView addSubview:self.content];
    
}

-(void)chargerAvecSalle:(Theater *)cinema{
    self.cinema = cinema;
    
    OCAppDelegate *app = APP_DELEGATE;
    self.fromLocation = app.myLocationGPS;
    
    [self remplir];
}

-(void)placer
{
    if(!notFirst)
    {
        notFirst = YES;
        
        self.content.frame = CGRectMake(0,0,self.contentView.frame.size.width,SALLE_CELL_HEIGHT);
        self.content.clipsToBounds = YES;
        
        self.gradient_black50_black20_view.frame = self.content.bounds;
        self.gradient_black50_black20.frame = self.gradient_black50_black20_view.bounds;
        
        self.gradient_black100_view.frame = self.content.bounds;
        self.gradient_black100.frame = self.gradient_black100_view.bounds;
        
        self.splash_stripes_repeat.frame = self.content.bounds;
        
        int sizeImage = 150;
        self.logo_defaut.frame = CGRectMake(self.content.frame.size.width - sizeImage, 0, sizeImage, SALLE_CELL_HEIGHT);
        
        
        self.horaires.frame = CGRectMake(0,self.content.frame.size.height - 25, self.content.frame.size.width, 25);
        
        
        self.nomCine.frame = CGRectMake(100,self.horaires.frame.origin.y - 40, 200, 20);
        
        self.adresse.frame = CGRectMake(100,self.horaires.frame.origin.y - 22, 200, 20);
        
        self.distance.frame = CGRectMake(self.content.frame.size.width - 75 ,self.horaires.frame.origin.y - 22, 70, 20);
        
        self.porte.frame = CGRectMake(0,0, 100, SALLE_CELL_HEIGHT);
        
        
        self.ic_handicap.frame = CGRectMake(20, 40, 20, 20);
        
        
    }
}

-(void) remplir{
    
    self.hidden = NO;
    
    if(self.cinema == nil)
        self.hidden = YES;
    
    [self placer];
    
    
    [self chargerEnFonctionDuCinema];
    
    
    
    [self.nomCine setText:self.cinema.name];
    
    
    [self.adresse setText:[NSString stringWithFormat:@"%@ %@",self.cinema.postalCode,self.cinema.city]];
    
    CLLocation *locTo = [[CLLocation alloc] initWithLatitude:self.cinema.geoloc.lat longitude:self.cinema.geoloc._long];
    
    CLLocationDistance distance = [self.fromLocation distanceFromLocation:locTo];
    
    distance = distance /1000;
    
    [self.distance setText:[NSString stringWithFormat:@" %0.1f km",distance]];
    [self.distance sizeToFit];
    self.distance.frame = CGRectMake(self.content.frame.size.width - self.distance.frame.size.width - 5, self.horaires.frame.origin.y - self.distance.frame.size.height - 3 , self.distance.frame.size.width, self.distance.frame.size.height);
    
    self.ic_nav.frame = CGRectMake(self.distance.frame.origin.x - 15 ,self.distance.frame.origin.y +1 , 10, 10);
    
    if(self.cinema.geoloc == nil){
        self.ic_nav.hidden = YES;
        self.distance.hidden = YES;
    }
    
    if (self.cinema.hasPRMAccess == 1)
        self.ic_handicap.hidden = NO;
    else
        self.ic_handicap.hidden = YES;
    
}


-(void) chargerEnFonctionDuCinema {
    
    NSString * name = [[self.cinema.name stringByReplacingOccurrencesOfString:@"é" withString:@"e"] uppercaseString];
    
    NSString * imageFond;
    NSString * couleurFond = @"#E0E0E0";
    
    if([name containsString:@"CGR"]){
        couleurFond = @"#ff8171";
        imageFond = @"logo_cgr.png";
    } else if([name containsString:@"GAUMONT"]){
        couleurFond = @"#d9002f";
        imageFond = @"logo_gaumont.png";
    } else if([name containsString:@"GAUMONT-PATHE"]){
        couleurFond = @"#eba14c";
        imageFond = @"logo_gaumont_pathe.png";
    } else if([name containsString:@"KINEPOLIS"]){
        couleurFond = @"#2170a1";
        imageFond = @"logo_kinepolis.png";
    } else if([name containsString:@"MEGARAMA"]){
        couleurFond = @"#6990ff";
        imageFond = @"logo_megarama.png";
    } else if([name containsString:@"MK2"]){
        couleurFond = @"#505050";
        imageFond = @"logo_mk2.png";
    } else if([name containsString:@"PATHE"]){
        couleurFond = @"#dac872";
        imageFond = @"logo_pathe.png";
    } else if([name containsString:@"UGC"]){
        couleurFond = @"#4763bf";
        imageFond = @"logo_ugc.png";
    } else {
        couleurFond = @"#A0A0A0";
        imageFond = @"logo_default.png";
    }
    
    self.logo_defaut.image = [UIImage imageNamed:imageFond];
    [self.content setBackgroundColor:[UIColor colorFromHexString:couleurFond]];
}

@end
