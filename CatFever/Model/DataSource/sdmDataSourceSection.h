//
//  sdmDataSourceSection.h
//  CatFever
//
//  Created by Peter JC Spencer on 03/06/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

/* *********************** Supported string constant(s) *********************** */
UIKIT_EXTERN NSString *const sdmDataSourceSectionUnkown;


@interface sdmDataSourceSection : NSObject

// Property(s).
@property(nonatomic, copy) NSArray *objects;
@property(nonatomic, readonly) NSString *reuseIdentifier;
@property(nonatomic, readonly) id cell;

// Creating a data source section.
- (instancetype)initWithObjects:(NSArray *)objects;

// Utilising the cell.
- (void)modifyCell:(id)cell withObjectAtIndex:(NSInteger)index;
- (CGFloat)heightForCellAtIndex:(NSInteger)index;

@end


