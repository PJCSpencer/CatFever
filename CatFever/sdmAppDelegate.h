//
//  sdmAppDelegate.h
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sdmRootController;


@interface sdmAppDelegate : UIResponder <UIApplicationDelegate>

// Property(s).
@property(strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) sdmRootController *rootController;

@end


