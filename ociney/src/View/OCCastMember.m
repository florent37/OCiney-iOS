//
//  OCCastMember.m
//  ociney
//
//  Created by florent champigny on 02/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "OCCastMember.h"
#import "Color+Hex.h"
#import "UIImageView+WebCache.h"

@implementation OCCastMember
{
    BOOL first;
    BOOL placer;
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        first = YES;
        placer = YES;
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
    if(first)
    {
        first = NO;
        [self addSubview:self.content = [UIView new]];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.content addSubview:self.fondJaquette = [UIView new]];
        self.fondJaquette.backgroundColor = [UIColor colorFromHexString:WHITE20];
        
        [self.content addSubview:self.fondInformation = [UIView new]];
        self.fondInformation.backgroundColor = [UIColor colorFromHexString:BLACK50];
        
        [self.content addSubview:self.imageCast = [UIImageView new]];
        
        
        
        [self.fondInformation addSubview:self.nomMember = [UILabel new]];
        
        self.nomMember.textAlignment = NSTextAlignmentLeft;
        self.nomMember.numberOfLines = 1 ;
        self.nomMember.font = [UIFont fontWithName:REGULAR size:11];
        self.nomMember.textColor = [UIColor colorFromHexString:WHITE90];
        
        [self.fondInformation addSubview:self.roles = [UILabel new]];
        
        self.roles.textAlignment = NSTextAlignmentLeft;
        self.roles.numberOfLines = 1 ;
        self.roles.font = [UIFont fontWithName:LIGHT_ITALIC size:9];
        self.roles.textColor = [UIColor colorFromHexString:WHITE50];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(clickMember)]];
    }
}

-(void)placer
{
    if(placer)
    {
        placer = NO;
        self.content.frame = CGRectMake(0, 0, self.bounds.size.width, 80);
        self.fondJaquette.frame = CGRectMake(0,0, 60, self.content.frame.size.height);
        self.fondInformation.frame = CGRectMake(60,25, self.content.frame.size.width - 60, 35);
        self.nomMember.frame = CGRectMake(5,5, self.fondInformation.frame.size.width - 10, 15);
        self.imageCast.frame = CGRectMake(5,5, 50, 70);
        self.roles.frame = CGRectMake(5,18, self.bounds.size.width - 60 - 10, 15);
    }
}

-(void)remplir
{
    [self creer];
    [self placer];
    
    if(self.member == nil)
        self.content.hidden = YES;
    else
        self.content.hidden = NO;

    [self.imageCast sd_setImageWithURL:[NSURL URLWithString:self.member.picture.href]];
    self.nomMember.text = self.member.person.name;
    self.roles.text = self.member.role;
}

-(void)clickMember
{
    [self.delegate onStarClicked:self.member];
}

-(void)loadMember:(CastMember*)member
{
    self.member = member;
    [self remplir];
}

@end
