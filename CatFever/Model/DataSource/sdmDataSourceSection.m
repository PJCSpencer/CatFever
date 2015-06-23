//
//  sdmDataSourceSection.m
//  CatFever
//
//  Created by Peter JC Spencer on 03/06/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmDataSourceSection.h"

NSString *const sdmDataSourceSectionUnkown = @"com.spencers-dm.catFever.dataSourceSection.unkown";


@implementation sdmDataSourceSection


#pragma mark -

- (id)init {
    
    self = [super init];
    if (self)
    {
        _objects = [[NSArray alloc] init];
    }
    return self;
}


#pragma mark -

- (instancetype)initWithObjects:(NSArray *)newObject
{
    self = [super init];
    if (self)
    {
        _objects = [[NSArray alloc] initWithArray:newObject];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        session.configuration.allowsCellularAccess = NO;
        session.configuration.timeoutIntervalForRequest = 10;
        session.configuration.timeoutIntervalForResource = 30;
        session.configuration.HTTPMaximumConnectionsPerHost = 5;
        [session.configuration setHTTPAdditionalHeaders: @{@"Accept":@"image/*"} ];
    }
    return self;
}


#pragma mark -

- (NSString *)reuseIdentifier { return sdmDataSourceSectionUnkown; }


#pragma mark -

- (id)cell { return nil; }


- (void)modifyCell:(id)cell withObjectAtIndex:(NSInteger)index { /* Do nothing, subclasses can override. */ }


- (CGFloat)heightForCellAtIndex:(NSInteger)index { return 72.0f; }


@end


