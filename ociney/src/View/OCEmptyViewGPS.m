//
//  OCEmptyViewGPS.m
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 03/01/2015.
//  Copyright (c) 2015 bdc. All rights reserved.
//

#import "OCEmptyViewGPS.h"
#import "Color+Hex.h"

@implementation OCEmptyViewGPS

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:(CGRect)frame]){

        
        self.arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
        self.arrow.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.arrow];
        
        self.gps_not_found_message = [UILabel new];
        self.gps_not_found_message.textAlignment = NSTextAlignmentRight;
        self.gps_not_found_message.numberOfLines = 3;
        [self.gps_not_found_message setTextColor:[UIColor colorFromHexString:WHITE70]];
        [self.gps_not_found_message setText:@"Nous n\'avons trouvé aucun cinéma, vous pouvez toujours en rechercher un !"];
        self.gps_not_found_message.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
        
        [self addSubview:self.gps_not_found_message];
        
    }
    return self;
}

-(void)positionner
{
    self.arrow.frame = CGRectMake(self.frame.size.width - 50, 5, 50, 75);
    self.gps_not_found_message.frame = CGRectMake(self.arrow.frame.origin.x - 10 - 150, self.arrow.frame.origin.y + 5 , 150, 50);
}

@end
