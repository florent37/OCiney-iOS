//
//  ServiceSecurity.h
//  ociney
//
//  Created by Kevin De Jesus Ferreira on 25/10/2014.
//  Copyright (c) 2014 bdc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceSecurity : NSObject

+(NSString *)sha1:(NSString *)str;

+(NSString *) getSed;

+(NSString *) getSIG:(NSString *)params
              andSed:(NSString *)sed;

+(NSString *) construireParams:(BOOL)ajouterCode
                     andParams:(NSArray *)params;

+(NSString *) applatir:(NSArray *)liste;

@end
