//
//  MovieDetailContent.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/11/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "MovieDetailContent.h"
#import "Color+Hex.h"
#import "Constantes.h"
#import "UIImageView+WebCache.h"
#import "PersonFull.h"
#import "OCCastMember.h"

#define HAUTEUR_AVANCEMENT 20
#define MARGIN_TOP 30


@interface MovieDetailContent(){
    int widthInsideScroll;
    BOOL notFirstCreated;
}

@end

@implementation MovieDetailContent


-(void)chargerAvecMovie:(Movie *)movie{
    self.movie = movie;
    [self setNeedsLayout];
    
}

- (void)layoutSubviews{
    
    if(!notFirstCreated)
    {
        notFirstCreated = YES;
        
        
        self.scrollContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.frame.size.width, self.frame.size.height)];
        self.scrollContent.bounces = NO;
        
        self.scrollContent.contentSize = CGSizeMake(self.frame.size.width, MAXFLOAT);
        
        
        widthInsideScroll = self.scrollContent.frame.size.width - 80;
        
        [self chargerContentHoraires];
        
        [self chargerContentNotes];
        
        [self chargerContentSynopsis];
        
        [self chargerInfo];
        
        [self chargerCasting];
        
        [self chargerContentMembers];
        
        [self addSubview:self.scrollContent];
        
        
        self.scrollContent.contentSize = CGSizeMake(self.frame.size.width,
                                                    self.contentMembers.frame.size.height + self.contentMembers.frame.origin.y + 50
                                                    );
        
    }
}


-(void) chargerContentHoraires
{
    
    
    if(self.movie.hasShowtime != 1){
        self.contentHoraire.frame = CGRectZero;
        self.contentHoraire.clipsToBounds = YES;
    }else{
        self.contentHoraire = [[UIView alloc]initWithFrame:CGRectMake(0, 0, widthInsideScroll, 30)];
        
        {
            
            [self.contentHoraire addSubview:(self.shapeRound = [UIView new])];
            self.shapeRound.backgroundColor=[UIColor blackColor];
            [self.shapeRound addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(horairesClicked)]];
            
            self.shapeRound.frame = CGRectMake(0, 15, self.frame.size.width-60, 55);
            self.shapeRound.layer.cornerRadius = self.shapeRound.frame.size.height/2;
            self.shapeRound.center = CGPointMake(self.contentHoraire.frame.size.width/2, self.shapeRound.center.y);
            
            
            [self.shapeRound addSubview:(self.imageSalle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_drawer_salles.png"]])];
            self.imageSalle.contentMode = UIViewContentModeScaleAspectFit;
            self.imageSalle.frame = CGRectMake(18,0, 40, 40);
            self.imageSalle.center = CGPointMake(self.imageSalle.center.x, self.shapeRound.frame.size.height/2);
            
            [self.shapeRound addSubview:self.imageSalle];
            
            {
                [self.shapeRound addSubview:(self.texteExplication = [UILabel new])];
                self.texteExplication.textAlignment = NSTextAlignmentLeft;
                self.texteExplication.numberOfLines = 2;
                [self.texteExplication setTextColor:[UIColor colorFromHexString:WHITE90]];
                self.texteExplication.font = [UIFont fontWithName:THIN size:13];
                
                self.texteExplication.text = @"Trouvez une salle à proximité ... \nou plus loin qu'à proximité";
                
                int x = self.imageSalle.frame.origin.x + self.imageSalle.frame.size.width + 10;
                int width = self.shapeRound.bounds.size.width - x;
                int height = 50;
                self.texteExplication.frame = CGRectMake(x, 0, width, height);
                self.texteExplication.center = CGPointMake(self.texteExplication.center.x, self.shapeRound.bounds.size.height/2);
            }
            
        }
        
        
        self.contentHoraire.frame = CGRectMake(0, 0, widthInsideScroll, self.shapeRound.frame.origin.y + self.shapeRound.frame.size.height);
        self.contentHoraire.center = CGPointMake(self.center.x, self.contentHoraire.center.y);
    }
    
    [self.scrollContent addSubview:self.contentHoraire];
}

-(void) chargerContentNotes
{
    
    self.contentNotes = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentHoraire.frame.origin.y + self.contentHoraire.frame.size.height + MARGIN_TOP,widthInsideScroll, 100)];
    
    self.contentNotes.center = CGPointMake(self.center.x, self.contentNotes.center.y);
    
    
    {
        self.titleNotes = [[UILabel alloc]initWithFrame:CGRectMake(0,0,300,20)];
        [self.titleNotes setText:@"LES NOTES"];
        self.titleNotes.alpha = 0.3;
        self.titleNotes.textAlignment = NSTextAlignmentLeft;
        [self.titleNotes setTextColor:[UIColor whiteColor]];
        self.titleNotes.font = [UIFont fontWithName:BLACK size:25];
        [self.contentNotes addSubview:self.titleNotes];
        
        // Spectateur
        
        self.viewBackSpectateur = [[UIView alloc]initWithFrame:CGRectMake(0, HAUTEUR_AVANCEMENT+MARGIN_TOP, self.contentNotes.frame.size.width, 9)];
        [self.viewBackSpectateur setBackgroundColor:[UIColor colorFromHexString:@"#333"]];
        
        [self.contentNotes addSubview:self.viewBackSpectateur];
        
        self.viewFrontSpectateur = [[UIView alloc]initWithFrame:CGRectMake(0, HAUTEUR_AVANCEMENT+MARGIN_TOP, 0, 9)];
        [self.viewFrontSpectateur setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentNotes addSubview:self.viewFrontSpectateur];
        
        
        self.viewAvancementSpectateur = [[UIView alloc]initWithFrame:CGRectMake(0, MARGIN_TOP, 1, HAUTEUR_AVANCEMENT)];
        [self.viewAvancementSpectateur setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentNotes addSubview:self.viewAvancementSpectateur];
        
        self.noteSpectateur = [[UILabel alloc]initWithFrame:CGRectMake(-45, MARGIN_TOP, 40, 15)];
        [self.noteSpectateur setText:[NSString stringWithFormat:@"%.01f",self.movie.statistics.userRating]];
        self.noteSpectateur.textAlignment = NSTextAlignmentRight;
        [self.noteSpectateur setTextColor:[UIColor whiteColor]];
        self.noteSpectateur.font = [UIFont fontWithName:THIN size:13];
        [self.contentNotes addSubview:self.noteSpectateur];
        
        // PRESSE
        
        self.viewBackPresse = [[UIView alloc]initWithFrame:CGRectMake(0, HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height - 10, self.contentNotes.frame.size.width, 9)];
        
        [self.viewBackPresse setBackgroundColor:[UIColor colorFromHexString:@"#333"]];
        
        [self.contentNotes addSubview:self.viewBackPresse];
        
        self.viewFrontPresse = [[UIView alloc]initWithFrame:CGRectMake(0, HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height - 10, 0, 9)];
        [self.viewFrontPresse setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentNotes addSubview:self.viewFrontPresse];
        
        
        self.viewAvancementPresse = [[UIView alloc]initWithFrame:CGRectMake(0, HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height - 1, 1, HAUTEUR_AVANCEMENT)];
        [self.viewAvancementPresse setBackgroundColor:[UIColor whiteColor]];
        
        [self.contentNotes addSubview:self.viewAvancementPresse];
        
        self.notePresse = [[UILabel alloc]initWithFrame:CGRectMake(-45, HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height + 5, 40, 15)];
        [self.notePresse setText:[NSString stringWithFormat:@"%.01f",self.movie.statistics.pressRating]];
        self.notePresse.textAlignment = NSTextAlignmentRight;
        [self.notePresse setTextColor:[UIColor whiteColor]];
        self.notePresse.font = [UIFont fontWithName:THIN size:13];
        [self.contentNotes addSubview:self.notePresse];
        
        int max = 5;
        
        float largeurMax = self.contentNotes.frame.size.width;
        float pourcentSpectateur = self.movie.statistics.userRating / max;
        float pourcentPresse = self.movie.statistics.pressRating / max;
        
        int largeurSpectateur = (int) (largeurMax * pourcentSpectateur);
        int largeurPresse = (int) (largeurMax * pourcentPresse);
        
        
        // Animation
        
        [UIView animateWithDuration:0.9 delay:2 options:UIViewAnimationOptionCurveLinear animations:^(void) {
            
            
            // Spectateur
            
            self.viewFrontSpectateur.frame = CGRectMake(0, HAUTEUR_AVANCEMENT+MARGIN_TOP, largeurSpectateur, 9);
            self.viewAvancementSpectateur.frame = CGRectMake(self.viewFrontSpectateur.frame.size.width-1, MARGIN_TOP, 1, HAUTEUR_AVANCEMENT);
            
            self.noteSpectateur.frame = CGRectMake(self.viewAvancementSpectateur.frame.origin.x-5- self.noteSpectateur.frame.size.width,
                                                   MARGIN_TOP,
                                                   40,
                                                   15);
            
            // Presse
            
            self.viewFrontPresse.frame = CGRectMake(0,
                                                    HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height - 10,
                                                    largeurPresse,
                                                    9);
            
            self.viewAvancementPresse.frame = CGRectMake(self.viewFrontPresse.frame.size.width-1
                                                         , HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height - 1,
                                                         1,
                                                         HAUTEUR_AVANCEMENT);
            
            self.notePresse.frame = CGRectMake(self.viewAvancementPresse.frame.origin.x-5- self.notePresse.frame.size.width,
                                               HAUTEUR_AVANCEMENT + self.viewFrontSpectateur.frame.origin.y + self.viewFrontSpectateur.frame.size.height + 5,
                                               40,
                                               15);
            
        } completion:^(BOOL finished) {} ];
    }
    
    self.contentNotes.frame = CGRectMake(self.contentNotes.frame.origin.x,self.contentNotes.frame.origin.y, self.contentNotes.frame.size.width,self.viewAvancementPresse.frame.origin.y + self.viewAvancementPresse.frame.size.height);
    self.contentNotes.center = CGPointMake(self.center.x, self.contentNotes.center.y);
    
    [self.scrollContent addSubview:self.contentNotes];
    
}

-(void) chargerContentSynopsis
{
    
    self.contentSynopsis = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentNotes.frame.origin.y + self.contentNotes.frame.size.height + MARGIN_TOP,widthInsideScroll, 100)];
    
    self.contentSynopsis.center = CGPointMake(self.center.x, self.contentSynopsis.center.y);
    
    {
        self.titleSynopsis = [[UILabel alloc]initWithFrame:CGRectMake(0,0,300,20)];
        [self.titleSynopsis setText:@"SYNOPSIS"];
        self.titleSynopsis.alpha = 0.3;
        self.titleSynopsis.textAlignment = NSTextAlignmentLeft;
        //[self.titleSynopsis sizeToFit];
        [self.titleSynopsis setTextColor:[UIColor whiteColor]];
        
        self.titleSynopsis.font = [UIFont fontWithName:BLACK size:25];
        [self.contentSynopsis addSubview:self.titleSynopsis];
        
        NSMutableParagraphStyle *paragraphStyles = [[NSMutableParagraphStyle alloc] init];
        paragraphStyles.alignment = NSTextAlignmentJustified;      //justified text
        paragraphStyles.firstLineHeadIndent = 10.0;
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyles};
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[self.movie getSynopsis]attributes: attributes];
        
        self.synopsisLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,30,self.contentSynopsis.frame.size.width,20)];
        self.synopsisLabel.font = [UIFont fontWithName:REGULAR size:12];
        [self.synopsisLabel setTextColor:[UIColor whiteColor]];
        self.synopsisLabel.numberOfLines = 0;
        self.synopsisLabel.textAlignment = NSTextAlignmentLeft;
        self.synopsisLabel.attributedText = attributedString;
        [self.synopsisLabel sizeToFit];
        [self.contentSynopsis addSubview:self.synopsisLabel];
        
        
    }
    
    self.contentSynopsis.frame = CGRectMake(self.contentSynopsis.frame.origin.x,self.contentSynopsis.frame.origin.y, self.contentSynopsis.frame.size.width,self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height);
    
    self.contentSynopsis.center = CGPointMake(self.center.x, self.contentSynopsis.center.y);
    
    [self.scrollContent addSubview:self.contentSynopsis];
}


-(void) chargerInfo
{
    
    self.contentInfo = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentSynopsis.frame.origin.y + self.contentSynopsis.frame.size.height + MARGIN_TOP,widthInsideScroll, 100)];
    
    self.contentInfo.center = CGPointMake(self.center.x, self.contentInfo.center.y);
    
    {
        
        self.descriptionDateSortie = [[UILabel alloc]initWithFrame:CGRectMake(0,0,100,20)];
        [self.descriptionDateSortie setText:@"Date de sortie :"];
        self.descriptionDateSortie.textAlignment = NSTextAlignmentLeft;
        self.descriptionDateSortie.font = [UIFont fontWithName:LIGHT size:12];
        [self.descriptionDateSortie setTextColor:[UIColor colorFromHexString:WHITE65]];
        
        [self.contentInfo addSubview:self.descriptionDateSortie];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
        NSDate *today = [cal dateFromComponents:components];
        
        NSDate *dateRelease = [dateFormatter dateFromString:[self.movie._release getReleaseDate]];
        
        if(self.movie != nil && dateRelease != nil)
            components = [cal components:(NSCalendarUnitEra|NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:dateRelease];
        NSDate *otherDate = nil;
        
        if(components != nil)
            otherDate = [cal dateFromComponents:components];
        
        int yDescription = 30;
        
        if([today compare:otherDate] == NSOrderedAscending) {
            yDescription = 0;
            self.valueDateSortie = [[UILabel alloc]initWithFrame:CGRectZero];
            self.descriptionDateSortie.frame = CGRectZero;
            
        }else{
            self.valueDateSortie = [[UILabel alloc]initWithFrame:CGRectMake(self.contentInfo.frame.size.width - 100,0,100,20)];
            
            NSDateFormatter *inDateFormatter = [[NSDateFormatter alloc] init];
            [inDateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *d = [inDateFormatter dateFromString:self.movie._release.releaseDate];
            
            NSDateFormatter *outDateFormatter = [[NSDateFormatter alloc] init];
            [outDateFormatter setDateFormat:@"dd/MM/yyyy"];
            self.valueDateSortie.text = [outDateFormatter stringFromDate:d ];
            
            self.valueDateSortie.textAlignment = NSTextAlignmentRight;
            self.valueDateSortie.numberOfLines = 1 ;
            self.valueDateSortie.font = [UIFont fontWithName:BOLD size:11];
            self.valueDateSortie.textColor = [UIColor colorFromHexString:WHITE75];
        }
        
        [self.contentInfo addSubview:self.valueDateSortie];
        
        
        
        if(self.movie.originalTitle != nil && ![self.movie sameTitleAndOriginalTitle]){
            self.descriptionTitreOriginal = [[UILabel alloc]initWithFrame:CGRectMake(0,yDescription,100,20)];
            [self.descriptionTitreOriginal setText:@"Titre original :"];
            self.descriptionTitreOriginal.textAlignment = NSTextAlignmentLeft;
            self.descriptionTitreOriginal.font = [UIFont fontWithName:LIGHT size:12];
            [self.descriptionTitreOriginal setTextColor:[UIColor colorFromHexString:WHITE65]];
            
            [self.contentInfo addSubview:self.descriptionTitreOriginal];
            
            self.valueTitreOriginal = [[UILabel alloc]initWithFrame:CGRectMake(self.contentInfo.frame.size.width - 100,30,100,20)];
            [self.valueTitreOriginal setText:self.movie.originalTitle];
            self.valueTitreOriginal.textAlignment = NSTextAlignmentRight;
            self.valueTitreOriginal.numberOfLines = 1 ;
            self.valueTitreOriginal.font = [UIFont fontWithName:BOLD size:11];
            [self.valueTitreOriginal setTextColor:[UIColor colorFromHexString:WHITE75]];
            
            [self.contentInfo addSubview:self.valueTitreOriginal];
            
            self.contentInfo.frame = CGRectMake(self.contentInfo.frame.origin.x,self.contentInfo.frame.origin.y, self.contentInfo.frame.size.width,self.valueTitreOriginal.frame.origin.y + self.valueTitreOriginal.frame.size.height);
        }else{
            self.valueTitreOriginal = [[UILabel alloc]initWithFrame:CGRectZero];
            self.descriptionTitreOriginal = [[UILabel alloc]initWithFrame:CGRectZero];
            
            self.contentInfo.frame = CGRectMake(self.contentInfo.frame.origin.x,self.contentInfo.frame.origin.y, self.contentInfo.frame.size.width,self.descriptionTitreOriginal.frame.origin.y + self.descriptionTitreOriginal.frame.size.height);
        }
    }
    
    
    self.contentInfo.center = CGPointMake(self.center.x, self.contentInfo.center.y);
    [self.scrollContent addSubview:self.contentInfo];
    
}

-(void) chargerCasting{
    
    self.contentCasting = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentInfo.frame.origin.y + self.contentInfo.frame.size.height + 20 + MARGIN_TOP,widthInsideScroll, 100)];
    
    self.contentCasting.center = CGPointMake(self.center.x, self.contentCasting.center.y);
    
    
    {
        
        self.titleCasting = [[UILabel alloc]initWithFrame:CGRectMake(0,0,300,20)];
        [self.titleCasting setText:@"CASTING"];
        
        self.titleCasting.alpha = 0.3;
        self.titleCasting.textAlignment = NSTextAlignmentLeft;
        //[self.titleCasting sizeToFit];
        [self.titleCasting setTextColor:[UIColor whiteColor]];
        
        self.titleCasting.font = [UIFont fontWithName:BLACK size:25];
        [self.contentCasting addSubview:self.titleCasting];
        
        self.contentCasting.userInteractionEnabled = YES;
        
        self.realisateur = [self.movie getRealisateur];
        
        if(self.realisateur != nil && self.realisateur.picture != nil && self.realisateur.picture.href != nil){
            
            
            self.fond = [[UIView alloc]initWithFrame:CGRectMake(0,35,self.contentCasting.frame.size.width-20, 55)];
            [self.fond setBackgroundColor:[UIColor blackColor]];
            
            [self.contentCasting addSubview:self.fond];
            
            
            self.fonction = [[UILabel alloc]initWithFrame:CGRectMake(5,5, 100, 15)];
            [self.fonction setText:@"Réalisateur"];
            self.fonction.textAlignment = NSTextAlignmentLeft;
            self.fonction.numberOfLines = 1 ;
            self.fonction.font = [UIFont fontWithName:LIGHT_ITALIC size:12];
            [self.fonction setTextColor:[UIColor colorFromHexString:WHITE50]];
            
            [self.fond addSubview:self.fonction];
            
            
            self.nameRealisateur = [[UILabel alloc]initWithFrame:CGRectMake(5,25, 100, 15)];
            [self.nameRealisateur setText:self.realisateur.person.name];
            self.nameRealisateur.textAlignment = NSTextAlignmentLeft;
            self.nameRealisateur.numberOfLines = 1 ;
            self.nameRealisateur.font = [UIFont fontWithName:REGULAR size:13];
            [self.nameRealisateur setTextColor:[UIColor whiteColor]];
            
            [self.fond addSubview:self.nameRealisateur];
            
            
            self.cercleFond = [[UIView alloc]initWithFrame:CGRectMake(self.contentCasting.frame.size.width-90,0,90, 90)];
            self.cercleFond.center = CGPointMake(self.cercleFond.center.x, self.fond.center.y);
            [self.cercleFond setBackgroundColor:[UIColor colorFromHexString:WHITE30]];
            self.cercleFond.layer.cornerRadius = 45;
            
            [self.contentCasting addSubview:self.cercleFond];
            
            self.imageRealisateur = [[UIImageView alloc]initWithFrame:CGRectMake(0,15,80, 80)];
            self.imageRealisateur.center = CGPointMake(self.cercleFond.center.x, self.fond.center.y);
            self.imageRealisateur.layer.masksToBounds = YES;
            self.imageRealisateur.layer.cornerRadius = 40;
            
            self.imageRealisateur.contentMode = UIViewContentModeScaleAspectFill;
            [self.imageRealisateur sd_setImageWithURL:[NSURL URLWithString:self.realisateur.picture.href]];

            
            [self.contentCasting addSubview:self.imageRealisateur];

            self.imageRealisateur.userInteractionEnabled = YES;
            [self.imageRealisateur addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(clickRealisateur:)]];
            
            
        }else{
            
            // Si il y a pas de réalisateur on cache la vue
            self.contentCasting.frame = CGRectMake(0,self.contentInfo.frame.origin.y + self.contentInfo.frame.size.height + MARGIN_TOP + 20,widthInsideScroll, 20);
            
            //    [self.contentCasting setBackgroundColor:[UIColor redColor]];
        }
        
    }
    
    self.contentCasting.frame = CGRectMake(self.contentCasting.frame.origin.x,self.contentCasting.frame.origin.y, self.contentCasting.frame.size.width,50);
    
    self.contentCasting.center = CGPointMake(self.center.x, self.contentCasting.center.y);
    
    self.scrollContent.userInteractionEnabled = YES;

    [self.scrollContent addSubview:self.contentCasting];
    
    
}


-(void) chargerContentMembers{
    
    if(self.realisateur != nil && self.realisateur.picture != nil && self.realisateur.picture.href != nil){
        
        self.contentMembers = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentCasting.frame.origin.y + self.contentCasting.frame.size.height + MARGIN_TOP + 30,widthInsideScroll, 100)];
    }else{
        self.contentMembers = [[UIView alloc]initWithFrame:CGRectMake(0,self.contentCasting.frame.origin.y + self.contentCasting.frame.size.height + MARGIN_TOP - 10,widthInsideScroll, 100)];
        
    }
    self.contentMembers.center = CGPointMake(self.center.x, self.contentMembers.center.y);
    
    
    {
        
        self.castMembers = [self.movie getCastMember:3];
        
        
        if([self.castMembers count] > 0){
            [self.contentMembers addSubview:[self createViewMember:[self.castMembers objectAtIndex:0] andX:0 andY:0 andTag:0]];
            
            if([self.castMembers count] > 1){
                [self.contentMembers addSubview:[self createViewMember:[self.castMembers objectAtIndex:1] andX:0 andY:90 andTag:1    ]];
                
                if([self.castMembers count] > 2){
                    [self.contentMembers addSubview:[self createViewMember:[self.castMembers objectAtIndex:2] andX:0 andY:180 andTag:2]];
                    
                    
                    self.plus_dashed_photos_white = [[UIImageView alloc]initWithFrame:CGRectMake(0, 270, 60, 80)];
                    self.plus_dashed_photos_white.image = [UIImage imageNamed:@"plus_dashed_photos_white.png"];
                    self.plus_dashed_photos_white.alpha = 0.2;
                    [self.contentMembers addSubview:self.plus_dashed_photos_white];
                    
                    self.plus_white = [[UIImageView alloc]initWithFrame:CGRectMake(0, 270, 20, 20)];
                    self.plus_white.contentMode = UIViewContentModeScaleAspectFit;
                    self.plus_white.center = CGPointMake(self.plus_dashed_photos_white.center.x, self.plus_dashed_photos_white.center.y);
                    self.plus_white.image = [UIImage imageNamed:@"plus_white.png"];
                    self.plus_white.alpha = 0.2;
                    [self.contentMembers addSubview:self.plus_white];
                    
                    self.plus_dashed_photos_white.userInteractionEnabled = YES;
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMoreStarClicked)];
                    [self.plus_dashed_photos_white addGestureRecognizer:tap];
                }
            }
        }
    }
    
    self.contentMembers.frame = CGRectMake(self.contentMembers.frame.origin.x,self.contentMembers.frame.origin.y, self.contentMembers.frame.size.width,80 * 4 + 40);
    
    self.contentMembers.center = CGPointMake(self.center.x, self.contentMembers.center.y);
    
    [self.scrollContent addSubview:self.contentMembers];
    
}

-(UIView *) createViewMember:(CastMember *)member andX:(int)x andY:(int) y andTag:(int)tag{
    
    OCCastMember *view = [OCCastMember new];
    view.member = member;
    view.delegate = self;
    view.tag = tag;
    view.frame = CGRectMake(x,y,widthInsideScroll,80);
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                       action:@selector(clickMember:)]];
    
    return view;
}

- (void)clickMember:(UITapGestureRecognizer *)recognizer {
    CastMember * member = [self.castMembers objectAtIndex:recognizer.view.tag];
    [self onStarClicked:member];
}

-(void)onStarClicked:(CastMember *)member
{
    PersonFull * person = [[PersonFull alloc]init];
    person.activity = member.person.activity;
    person.picture = member.picture;
    Name * name = [[Name alloc]init];
    name.family = member.person.name;
    name.given = @"";
    person.name = name;
    person.code = member.person.code;
    person.statistics = member.person.statistics;
    
    [self.delegate memberClicked:person];
}

-(void)onMoreStarClicked
{
    [self.delegate onMoreStarClicked];
}

- (void)clickRealisateur:(UITapGestureRecognizer *)recognizer {
    [self onStarClicked:self.realisateur];
}

- (void)resizeToFitSubviews:(UIView *)view
{
    float h;
    
    for (UIView *v in [view subviews]) {
        float fh = v.frame.origin.y + v.frame.size.height;
        h = MAX(fh, h);
    }
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, h)];
}


-(void)horairesClicked
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.imageSalle.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.imageSalle.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [self.delegate horairesClicked];
        }];
    }];
}


@end
