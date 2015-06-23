//
//  sdmRootController.h
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sdmTableViewDataSource;


@interface sdmRootController : UIViewController

// Property(s).
@property(nonatomic, strong) sdmTableViewDataSource *dataSource;

@end


