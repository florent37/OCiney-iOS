//
//  ServiceSecurity.m
//  Ociney
//
//  Created by Kevin De Jesus Ferreira on 25/10/2014.
//

#import "ServiceSecurity.h"
#import <CommonCrypto/CommonDigest.h>

#define ALLOCINE_SECRET_KEY @"29d185d98c984a359e6e6f26a0474269"
#define PARTNER @"partner"
#define ALLOCINE_PARTNER_KEY @"100043982026"
#define CODE @"code"
#define APP_ID @"27405"
#define FORMAT_JSON @"json"
#define FORMAT @"format"


@implementation ServiceSecurity

+(NSString *)sha1:(NSString *)str {
    
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    const char *cStr = [str UTF8String];
    CC_SHA1(cStr, (CC_LONG)strlen(cStr), result);
    NSData *pwHashData = [[NSData alloc] initWithBytes:result length: sizeof result];
    NSString *base64 = [pwHashData base64EncodedStringWithOptions:0];
    
    return  base64;
}


+(NSString *) getSed{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    return [dateFormat stringFromDate:[NSDate date]];
}


+(NSString *) getSIG:(NSString *)params
              andSed:(NSString *)sed{
    
    NSString * input = [NSString stringWithFormat:@"%@%@&sed=%@",ALLOCINE_SECRET_KEY,params,sed];
    
    
    input = [input stringByReplacingOccurrencesOfString: @":" withString:@"%3A"];
    input = [input stringByReplacingOccurrencesOfString: @"," withString:@"%2C"];
    
    NSString * sha1 = [[NSString alloc]initWithString:[self sha1:input]];

    NSString* newStr = [ServiceSecurity URLEncodedString_ch:sha1];

    return newStr;
    
}



+ (NSString *) URLEncodedString_ch:(NSString *)input {
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[input UTF8String];
    NSUInteger sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+(NSString *) applatir:(NSArray *)liste{
    
    NSString * sb = @"";
    
    for(NSString * s in liste){
        sb = [sb stringByAppendingString:@","];
        sb = [sb stringByAppendingString:s];
    }
    
    return sb;
}

+(NSString *) construireParams:(BOOL)ajouterCode
                     andParams:(NSArray *)params{
    
    
    NSMutableArray * ps = [[NSMutableArray alloc]init];
    [ps addObject:PARTNER];
    [ps addObject:ALLOCINE_PARTNER_KEY];
    
    if (ajouterCode){
        [ps addObject:CODE];
        [ps addObject:APP_ID];
    }
    
    [ps addObject:FORMAT];
    [ps addObject:FORMAT_JSON];
    
    [ps addObjectsFromArray:params];
    
    
    NSString * sb = @"";
    
    
    for (int i = 0; i < [ps count]; i += 2) {
        if (i + 1 < [ps count]) {
            if (i != 0)
                sb = [sb stringByAppendingString:@"&"];
            
            sb = [sb stringByAppendingString:[ps objectAtIndex:i]];
            sb = [sb stringByAppendingString:@"="];
            
            NSObject * value = [ps objectAtIndex:i+1];
            if ([value isKindOfClass:[NSString class]])
                sb = [sb stringByAppendingString:(NSString *)value];
            else if ([value isKindOfClass:[NSArray class]]) {
                sb = [sb stringByAppendingString:[self applatir:(NSArray *)value]];
            }
        }
    }
    return sb;
}



@end
