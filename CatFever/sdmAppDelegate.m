//
//  sdmAppDelegate.m
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmAppDelegate.h"

#import "sdmRootController.h"


@implementation sdmAppDelegate


#pragma mark - UIApplicationDelegate Protocol

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.rootController = [[sdmRootController alloc] initWithNibName:nil
                                                              bundle:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.rootController;
    
    // Display window.
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end


