Heroku-iOS-SDK
==============

Heroku iOS SDK is a simple wrap-up of the Heroku API for iOS. It's built on top of the wonderful networking library [AFNetworking](https://github.com/AFNetworking/AFNetworking) by Mattt Thompson and aims to provide a simple access to the Heroku API for all iOS developers.

## How To Get Started

- Download the [Heroku iOS SDK](https://github.com/alvesjtiago/Heroku-iOS-SDK/zipball/master) and [AFNetworking](https://github.com/AFNetworking/AFNetworking/zipball/master)
- Include them in your project
- Try some of the examples below

## Example Usage

### User authentication

``` objective-c
[HerokuSDK loginUserWithToken:self.tokenTextField.text
                          success:^(id responseObject) {
                              NSLog(@"User logged in");
                          } failure:^(NSError *error) {
                              NSLog(@"Failed to authenticate user: %@", error);
                          }];
```

### Fetch user apps

``` objective-c
[HerokuSDK getAppsWithSuccess:^(id responseObject) {
        NSLog(@"Apps array: %@", resposeObject);
    } failure:^(NSError *error) {
        NSLog(@"Failed: %@", error);
    }];
```

### Restart app

``` objective-c
[HerokuSDK restartAppNamed:[self.app objectForKey:@"name"]
                       success:^(id responseObject) {
                           NSLog(@"Restarted app with success");
                       } failure:^(NSError *error) {
                           NSLog(@"Failed to restart app");
                       }];
```

##Disclaimer

This is a work in progress and over time all Heroku API with its different versions will be covered by the Heroku iOS SDK. Feel free to send suggestions, fork it and improve it.