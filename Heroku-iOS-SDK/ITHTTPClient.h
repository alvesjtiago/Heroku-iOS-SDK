//
//  ITHTTPClient.h
//  Heroku Cockpit
//
//  Created by Tiago Alves on 3/27/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import "AFHTTPClient.h"

@interface ITHTTPClient : AFHTTPClient

- (void)setToken:(NSString*)token;

+ (ITHTTPClient *)sharedClient;

@end
