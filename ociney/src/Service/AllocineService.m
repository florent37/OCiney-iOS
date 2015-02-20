//
//  Service.m
//  WhatWhat
//
//  Created by Florent Champigny on 14/08/2014.
//  Copyright (c) 2014 Florent Champigny. All rights reserved.
//

#import "AllocineService.h"
#import "JSONHTTPClient.h"
#import "ServiceSecurity.h"

#define ENPOINT @"http://api.allocine.fr/rest/v3"


NSString* urlWebService(NSString* end){
    return [NSString stringWithFormat:@"%@%@",ENPOINT,end];
}

NSString* intToString(NSInteger i){
    return [NSString stringWithFormat:@"%ld",(long)i];
}

@implementation AllocineService

-(id)initWithDelegate:(id<ServiceDelegate>) serviceDelegate{
    if(self = [super init]){
        self.serviceDelegate = serviceDelegate;
        // self.session = [[SessionManager alloc] init];
    }
    return self;
}

-(void)POST:(NSString*)url parameters:(id)parameters
{
    [self POST_AFNETWORKING:urlWebService(url) parameters:parameters];
}


-(void)POST_AFNETWORKING:(NSString*)url parameters:(id)parameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",nil];
    
    [manager
     POST:url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSString *response = [operation responseString];
         
         if(self.serviceDelegate != nil)
             [self.serviceDelegate donneesRecues:response  andStatusCode:operation.response.statusCode andError:nil];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(self.serviceDelegate != nil)
             [self.serviceDelegate donneesRecues:nil andStatusCode:operation.response.statusCode andError:error];
     }];
}

-(void)GET:(NSString*)url parameters:(id)parameters andConstruireParams:(BOOL)construire
{
    if(parameters != nil && [parameters isKindOfClass:[NSArray class]]){
        NSArray *paramsArray = (NSArray*)parameters;
        NSString * parametres = [ServiceSecurity construireParams:construire
                                                        andParams:paramsArray];
        NSString * sed = [ServiceSecurity getSed];
        NSString * sig = [ServiceSecurity getSIG:parametres andSed:sed];
        NSString * p = [NSString stringWithFormat:@"%@&sed=%@&sig=%@",parametres,sed,sig];
        
        url = [NSString stringWithFormat:@"/%@?%@",url,p];
        url = urlWebService(url);
        
        [self GET_AFNETWORKING:url parameters:nil];
    }
    
    else
        [self GET_AFNETWORKING:urlWebService(url) parameters:parameters];
}

-(void)GET_AFNETWORKING:(NSString*)url parameters:(id)parameters
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",nil];
    
    [manager
     GET:  url
     parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if(self.serviceDelegate != nil){
             NSString *reponseString = operation.responseString;
             
             [self.serviceDelegate donneesRecues: reponseString andStatusCode:operation.response.statusCode andError:nil];
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if(self.serviceDelegate != nil)
             [self.serviceDelegate donneesRecues:nil andStatusCode:operation.response.statusCode andError:error];
     }];
}


-(void)movielist:(NSArray *)paramsArray
{
    [self
     GET:@"movielist"
     parameters:paramsArray andConstruireParams:YES
     ];
    
}


-(void)theaterlist:(NSArray *)paramsArray
{
    [self
     GET:@"theaterlist"
     parameters:paramsArray andConstruireParams:YES
     ];
    
}

-(void)showtimelistForTheater:(NSArray *)paramsArray
{
    [self
     GET:@"showtimelist"
     parameters:paramsArray andConstruireParams:NO
     ];
    
}

-(void)personList:(NSArray *)paramsArray
{
    [self
     GET:@"personList"
     parameters:paramsArray andConstruireParams:YES
     ];
    
}


-(void)movie:(NSArray *)paramsArray
{
    [self
     GET:@"movie"
     parameters:paramsArray andConstruireParams:NO
     ];
    
}

-(void)videoList:(NSArray *)paramsArray{
    [self
     GET:@"videolist"
     parameters:paramsArray andConstruireParams:NO
     ];
}

-(void)person:(NSArray *)paramsArray
{
    [self
     GET:@"person"
     parameters:paramsArray andConstruireParams:NO
     ];

}

-(void)search:(NSArray *)paramsArray
{
    [self
     GET:@"search"
     parameters:paramsArray andConstruireParams:YES
     ];
    
}

-(void)showtimelistForTheaterAndMovie:(NSArray *)paramsArray
{
    [self
     GET:@"showtimelist"
     parameters:paramsArray andConstruireParams:YES
     ];
}

-(void)showtimelistWithLatLngAndMovie:(NSArray *)paramsArray
{
    [self
     GET:@"showtimelist"
     parameters:paramsArray andConstruireParams:YES
     ];
}

@end
