//
//  LeftViewController.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 24/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import "LeftViewController.h"
#import "Color+Hex.h"
#import "OCAppDelegate.h"
#import "Constantes.h"

@interface LeftViewController (){
    OCAppDelegate * appDelegate;
    NSInteger tagSelectionner;
    BOOL first;
    UIButton * films;
    UIButton * stars;
    UIButton * salles;
    UIButton * credits;
    UIButton * favoris;

    int buttonY;
}

@end

#define HEIGHT_BUTTON 45.0
#define FONT_SIZE_BUTTON 19
#define FONT_NORMAL THIN
#define FONT_SELECTED BOLD

@implementation LeftViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    buttonY = 5;
    
    appDelegate = (OCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self charger];
    first = YES;
}


-(void) viewWillAppear:(BOOL)animated{
    
    //[appDelegate activeFond:YES andColor:[UIColor colorFromHexString:BLACK_70]];
    
    if(first){
        [self remplirVue];
        [self itemSelectionner:films];
    }
    else
        [self updateVue];
}

-(void) charger{
    tagSelectionner = FILMS_MENU;
}


-(void) remplirVue{
    
    first = false;
    
    
    self.content = [[UIView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    
    {
        self.gradientView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.content.frame.size.width,self.content.frame.size.height)];
        [self.content addSubview:self.gradientView];
        
        self.gradient = [CAGradientLayer layer];
        self.gradient.colors = @[(id) [[UIColor colorFromHexString:@"#333333ff"] CGColor], (id) [[UIColor colorFromHexString:@"#555555ff"] CGColor]];
        [self.gradientView.layer insertSublayer:self.gradient atIndex:0];
        self.gradient.frame = self.gradientView.bounds;

    }
    
    
    {
        films = [self createButton:@"Films" andImage:@"ic_drawer_films.png" andTag:FILMS_MENU];
    }
    
    {
        salles = [self createButton:@"Salles" andImage:@"ic_drawer_salles.png" andTag:SALLES_MENU];
    }
    
    {
        stars = [self createButton:@"Stars" andImage:@"ic_drawer_stars.png" andTag:STARTS_MENU];
    }
    
    /*
    {
        favoris = [self createButton:@"Favoris" andImage:@"ic_drawer_favoris.png" andTag:FAVORIS_MENU];
    }
     */
    
    {
        credits = [self createButton:@"Crédits" andImage:@"ic_drawer_credits.png" andTag:CREDITS_MENU];
    }
    
    [self.view addSubview:self.content];
    
}


-(UIButton *) createButton:(NSString *)textLabel
                  andImage:(NSString*)imageName
                    andTag:(int)tag
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    // Permet d'ajouter des actions en fonction des états du bouton
    [button addTarget:self
               action:@selector(changeColor:)
     forControlEvents:UIControlEventTouchDown];
    
    [button addTarget:self
               action:@selector(changeClearColor:)
     forControlEvents:UIControlEventTouchCancel];
    
    [button addTarget:self
               action:@selector(lancerItemMenu:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [button addTarget:self
               action:@selector(changeClearColor:)
     forControlEvents:UIControlEventTouchUpOutside];
    
    [button setTitle:textLabel forState:UIControlStateNormal];
    button.frame = CGRectMake(0,buttonY, self.view.bounds.size.width, HEIGHT_BUTTON);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // Permet de changer la couleur du texte en fonction du touch
    [button setTitleColor:[UIColor colorFromHexString:WHITE95] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    // Permet de mettre du padding à gauche
    [button.titleLabel setFont:[UIFont fontWithName:FONT_NORMAL size:19]];
    [button setTitleColor:[UIColor colorFromHexString:WHITE95] forState:UIControlStateNormal];
    button.titleLabel.center = CGPointMake(button.titleLabel.center.x, button.frame.size.height/2);
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 60.0, 0.0, 0.0)];
    
    // Permet de changer la couleur de fond
    [button setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10,0, 30, 30)];
    image.center = CGPointMake(image.center.x, button.frame.size.height/2);
    image.image = [UIImage imageNamed:imageName];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [button addSubview:image];
    button.tag = tag;
    
    buttonY += (HEIGHT_BUTTON+3);
    
    [self.content addSubview:button];
    
    return  button;
    
}

-(void)updateVue{
    [self resetAllItems];
    [self itemSelectionner:[self sendByTag:tagSelectionner]];
}


-(UIButton *)sendByTag:(NSInteger)tag{
    
    switch (tag) {
        case FILMS_MENU:
            return films;
        case STARTS_MENU:
            return stars;
        case SALLES_MENU:
            return salles;
        case CREDITS_MENU:
            return credits;
        case FAVORIS_MENU:
            return favoris;
    }
    
    return nil;
}



- (IBAction)changeClearColor:(UIButton *)sender
{
    tagSelectionner = (NSInteger)[sender tag];
    
    [sender setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)changeColor:(UIButton *)sender{
    
    //[sender setBackgroundColor:[UIColor colorFromHexString:GRAY_CELL]];
}


-(IBAction)lancerItemMenu:(UIButton *)sender{
    [self changeClearColor:sender];
    
        [self resetAllItems];
        [self itemSelectionner:sender];
        
        [appDelegate toggleLeftDrawer];
        [appDelegate changeTopViewController:[sender tag]];
    
}


-(void) resetAllItems
{
    UIFont *font = [UIFont fontWithName:FONT_NORMAL size:FONT_SIZE_BUTTON];
    UIColor *color = [UIColor colorFromHexString:WHITE95];
    
    
    [films.titleLabel setFont:font];
    [films setTitleColor:color forState:UIControlStateNormal];
    
    [stars.titleLabel setFont:font];
    [stars setTitleColor:color forState:UIControlStateNormal];
    
    
    [salles.titleLabel setFont:font];
    [salles setTitleColor:color forState:UIControlStateNormal];
    
    [favoris.titleLabel setFont:font];
    [favoris setTitleColor:color forState:UIControlStateNormal];
    
    [credits.titleLabel setFont:font];
    [credits setTitleColor:color forState:UIControlStateNormal];
}


-(void) itemSelectionner:(UIButton *)sender{
    
    /*
    switch (sender.tag) {
        case FILMS_MENU:
        {
            [sender.titleLabel setFont:[UIFont fontWithName:FONT_SELECTED size:FONT_SIZE_BUTTON]];
        }
            break;
            
        case STARTS_MENU:
        {
        }
            break;
    }
    [sender setTitleColor:[UIColor colorFromHexString:WHITE95] forState:UIControlStateNormal];
     
     */
    
    [sender.titleLabel setFont:[UIFont fontWithName:FONT_SELECTED size:FONT_SIZE_BUTTON]];

}

@end
