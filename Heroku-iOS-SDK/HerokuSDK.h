//
//  HerokuSDK.h
//  Heroku Cockpit
//
//  Created by Tiago Alves on 3/27/13.
//  Copyright (c) 2013 Iterar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HerokuSDK : NSObject

#pragma mark - User
+ (BOOL)hasUser;
+ (void)loginUserWithToken:(NSString*)token
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;
+ (void)logoutCurrentUser;
+ (void)getCurrentUserWithSuccess:(void (^)(id responseObject))success
                          failure:(void (^)(NSError *error))failure;


#pragma mark - Apps
+ (void)getAppsWithSuccess:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

+ (void)getInfoForAppNamed:(NSString*)app
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

+ (void)createAppNamed:(NSString*)app
              forStack:(NSString*)stack
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

+ (void)renameAppWithName:(NSString*)oldName
                   toName:(NSString*)newName
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

+ (void)transferAppWithName:(NSString*)app
                    toOwner:(NSString*)owner
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

+ (void)activateMaintenanceModeForAppWithName:(NSString*)app
                                      success:(void (^)(id responseObject))success
                                      failure:(void (^)(NSError *error))failure;

+ (void)deactivateMaintenanceModeForAppWithName:(NSString*)app
                                        success:(void (^)(id responseObject))success
                                        failure:(void (^)(NSError *error))failure;

+ (void)deleteAppNamed:(NSString*)app
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

+ (void)restartAppNamed:(NSString*)app
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

@end
