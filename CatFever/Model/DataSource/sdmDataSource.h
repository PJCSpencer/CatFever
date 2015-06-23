//
//  sdmDataSource.h
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "sdmDataSourceSection.h"


@interface sdmDataSource : NSObject

// Property(s).
@property(nonatomic, readonly) NSArray *sections;

// Creating a data source.
- (instancetype)initWithSections:(NSArray *)sections;
- (instancetype)initWithContentsOfJSONAtPath:(NSString *)path;

// Configuring a data source instance.
- (void)addSection;
- (void)insertSection:(NSInteger)sectionIndex;
- (void)removeSection:(NSInteger)sectionIndex;
- (void)removeAll;

// Utility loading.
- (void)reload;
- (void)reloadSection:(NSInteger)sectionIndex
          withObjects:(NSArray *)objects;

@end


