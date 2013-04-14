//
//  ITHTTPClient.m
//  Heroku Cockpit
//
//  Created by Tiago Alves on 3/27/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import "ITHTTPClient.h"
#import "AFNetworkActivityIndicatorManager.h"

#define kBaseURL @"https://api.heroku.com"

@implementation ITHTTPClient

#pragma mark - Singleton Methods

+ (ITHTTPClient *)sharedClient
{
    static dispatch_once_t pred;
    static ITHTTPClient *_sharedClient = nil;
    
    dispatch_once(&pred, ^{ _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]]; });
    return _sharedClient;
}

#pragma mark - Initialization

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if(!self)
        return nil;
    
    [self setDefaultHeader:@"Accept" value:@"application/json, text/html"];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"herokuApiToken"];
    if (token && ![token isEqualToString:@""]) {
        [self setToken:token];
    }
    
    return self;
}

#pragma mark - Authentication

- (void)setToken:(NSString *)token
{
    [self clearAuthorizationHeader];
    [self setAuthorizationHeaderWithUsername:@"" password:token];
}

@end