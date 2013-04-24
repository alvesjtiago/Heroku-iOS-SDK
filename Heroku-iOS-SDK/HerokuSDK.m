//
//  HerokuSDK.m
//  Heroku Cockpit
//
//  Created by Tiago Alves on 3/27/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import "HerokuSDK.h"
#import "ITHTTPClient.h"

@implementation HerokuSDK

#pragma mark - User

+ (BOOL)hasUser {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"herokuApiToken"];
    if (token && ![token isEqualToString:@""]) {
        [[ITHTTPClient sharedClient] setToken:token];
        return YES;
    } else {
        return NO;
    }
}

+ (void)loginUserWithToken:(NSString*)token
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure {
    [[ITHTTPClient sharedClient] setToken:token];
    [[ITHTTPClient sharedClient] getPath:@"/user"
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"herokuApiToken"];
                                     [[NSUserDefaults standardUserDefaults] synchronize];
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
}

+ (void)logoutCurrentUser {
    [[ITHTTPClient sharedClient] clearAuthorizationHeader];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"herokuApiToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)getCurrentUserWithSuccess:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure {
    
    [[ITHTTPClient sharedClient] getPath:@"/user"
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
    
}


#pragma mark - Apps

+ (void)getAppsWithSuccess:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure {
    
    [[ITHTTPClient sharedClient] getPath:@"/apps"
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
    
}

+ (void)getInfoForAppNamed:(NSString*)app
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure {
    
    [[ITHTTPClient sharedClient] getPath:[NSString stringWithFormat:@"/apps/%@", app]
                              parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
    
}

+ (void)createAppNamed:(NSString*)app
              forStack:(NSString*)stack
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    
    NSDictionary *appParameters = [NSDictionary dictionaryWithObjectsAndKeys:app, @"name", stack, @"stack", nil];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:appParameters forKey:@"app"];
    
    [[ITHTTPClient sharedClient] postPath:@"/apps"
                               parameters:parameters
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      success([self processResponse:responseObject]);
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      failure(error);
                                  }];
    
}

+ (void)renameAppWithName:(NSString*)oldName
                   toName:(NSString*)newName
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    
    NSDictionary *appParameters = [NSDictionary dictionaryWithObjectsAndKeys:newName, @"name", nil];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:appParameters forKey:@"app"];
    
    [[ITHTTPClient sharedClient] putPath:[NSString stringWithFormat:@"/apps/%@", oldName]
                              parameters:parameters
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
    
}

+ (void)transferAppWithName:(NSString*)app
                    toOwner:(NSString*)owner
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure {
    
    NSDictionary *appParameters = [NSDictionary dictionaryWithObjectsAndKeys:owner, @"transfer_owner", nil];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:appParameters forKey:@"app"];
    
    [[ITHTTPClient sharedClient] putPath:[NSString stringWithFormat:@"/apps/%@", app]
                              parameters:parameters
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
    
}

+ (void)activateMaintenanceModeForAppWithName:(NSString*)app
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure {
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"1" forKey:@"maintenance_mode"];
    
    [[ITHTTPClient sharedClient] postPath:[NSString stringWithFormat:@"/apps/%@/server/maintenance", app]
                              parameters:parameters
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     success([self processResponse:responseObject]);
                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     failure(error);
                                 }];
    
}

+ (void)deactivateMaintenanceModeForAppWithName:(NSString*)app
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure {
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"0" forKey:@"maintenance_mode"];
    
    [[ITHTTPClient sharedClient] postPath:[NSString stringWithFormat:@"/apps/%@/server/maintenance", app]
                               parameters:parameters
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      success([self processResponse:responseObject]);
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      failure(error);
                                  }];
}

+ (void)deleteAppNamed:(NSString*)app
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure {
    
    [[ITHTTPClient sharedClient] deletePath:[NSString stringWithFormat:@"/apps/%@", app]
                                 parameters:nil
                                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                        success([self processResponse:responseObject]);
                                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        failure(error);
                                    }];
    
}

+ (void)restartAppNamed:(NSString*)app
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure {
    
    [[ITHTTPClient sharedClient] postPath:[NSString stringWithFormat:@"/apps/%@/ps/restart", app]
                               parameters:nil
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      success([self processResponse:responseObject]);
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      failure(error);
                                  }];
    
}

# pragma mark - Private methods

// Workaround for Heroku's API accept headers
+ (id)processResponse:(id)response {
    if ([[response class] isSubclassOfClass:[NSData class]]) {
        id JSON = [NSJSONSerialization JSONObjectWithData:response
                                                  options:NSJSONReadingAllowFragments
                                                    error:nil];
        return JSON;
    } else {
        return response;
    }
}

@end
