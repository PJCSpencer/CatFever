//
//  sdmTableViewDataSource.m
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmTableViewDataSource.h"


@implementation sdmTableViewDataSource


#pragma mark - Creating, Copying, and Deallocating Objects (NSObject)

- (id)init
{
    self = [super init];
    if (self)
    {
        _tableView = nil;
    }
    return self;
}


#pragma mark - Creating, Copying, and Deallocating Objects (sdmDataSource)

- (id)initWithSections:(NSArray *)sections
{
    self = [super initWithSections:sections];
    if (self)
    {
        _tableView = nil;
    }
    return self;
}


#pragma mark - Creating a DataSource (sdmDataSource)

- (instancetype)initWithContentsOfJSONAtPath:(NSString *)path
{
    self = [super initWithContentsOfJSONAtPath:path];
    if (self)
    {
        _tableView = nil;
    }
    return self;
}


#pragma mark - Loading (sdmDataSource)

- (void)reloadSection:(NSInteger)sectionIndex
          withObjects:(NSArray *)objects
{
    // Super.
    [super reloadSection:sectionIndex withObjects:objects];
    
    // Update GUI.
    [_tableView reloadData];
}


#pragma mark - Property Implementation(s)

- (void)setTableView:(UITableView *)newObject {
    
    _tableView = newObject;
    
    // Error checking.
    if (_tableView)
    {
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView reloadData];
    }
}


#pragma mark - UIScrollViewDelegate Protocol

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // TODO: Delegate loading additional API data ...
}


#pragma mark - UITableViewDataSource Protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    sdmDataSourceSection *dataSourceSection = self.sections[section];
    return dataSourceSection.objects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    sdmDataSourceSection *dataSourceSection = self.sections[indexPath.section];
    id cell = [tableView dequeueReusableCellWithIdentifier:dataSourceSection.reuseIdentifier];
    
    if (cell == nil)
        cell = dataSourceSection.cell;
    
    [dataSourceSection modifyCell:cell withObjectAtIndex:indexPath.row];
    
    return (UITableViewCell *)cell;
}


#pragma mark - UITableViewDelegate Protocol

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    sdmDataSourceSection *dataSourceSection = self.sections[indexPath.section];
    return [dataSourceSection heightForCellAtIndex:indexPath.row];
}


@end


