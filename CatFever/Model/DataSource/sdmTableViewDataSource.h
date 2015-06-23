//
//  sdmTableViewDataSource.h
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmDataSource.h"


@interface sdmTableViewDataSource : sdmDataSource <UITableViewDataSource, UITableViewDelegate>

// Property(s).
@property(nonatomic, weak) UITableView *tableView;

@end


