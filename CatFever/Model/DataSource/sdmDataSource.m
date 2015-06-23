//
//  sdmDataSource.m
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmDataSource.h"


@implementation sdmDataSource


#pragma mark - Creating, Copying, and Deallocating Objects (NSObject)

- (instancetype)init {
    
    self = [super init];
    if (self)
    {
        _sections = [[NSArray alloc] init];
    }
    return self;
}


#pragma mark - Creating a DataSource

- (instancetype)initWithSections:(NSArray *)newObject
{
    self = [super init];
    if (self)
    {
        // Validate argument content(s).
        for (id object in newObject)
            NSAssert([object isKindOfClass:[sdmDataSourceSection class]],
                     @"Failed: Data source object must be DataSourceSection instance.");
        
        _sections = [[NSArray alloc] initWithArray:newObject];
    }
    return self;
}


- (instancetype)initWithContentsOfJSONAtPath:(NSString *)path
{
    NSAssert(path, @"Possible missing or incorrect path: %@.", path);
    
    self = [super init];
    if (self)
    {
        _sections = nil;

        NSError *error = nil;
        NSString *file = [[NSString alloc] initWithContentsOfFile:path
                                                         encoding:NSUTF8StringEncoding
                                                            error:&error];
        NSAssert(file, @"Failed to instanciate string: %@.", file);
        
        if (!error)
        {
            NSDictionary *data = nil;
            data = [NSJSONSerialization JSONObjectWithData:[file dataUsingEncoding:NSUTF8StringEncoding]
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
            NSAssert(data, @"Failed to instanciate json: %@.", data);
            
            NSArray *collection = data[@"sections"];
            if (collection.count)
            {
                Class class;
                NSMutableArray *buffer = nil;
                buffer = [NSMutableArray arrayWithCapacity:0];
                
                for (NSDictionary *object in collection)
                {
                    // Cast.
                    class = NSClassFromString((NSString *)object[@"class"]);
                    NSAssert([class isSubclassOfClass:[sdmDataSourceSection class]],
                             @"Possible incorrect class: %@.",
                             class);
                    
                    [buffer addObject:[class new]];
                }
                _sections = [[NSArray alloc] initWithArray:buffer];
            }
        }
    }
    return self;
}


#pragma mark - Configuring a Data Source

- (void)addSection { /* TODO: */ }


- (void)insertSection:(NSInteger)sectionIndex { /* TODO: */ }


- (void)removeSection:(NSInteger)sectionIndex { /* TODO: */ }


- (void)removeAll { /* TODO: */ }


#pragma mark - Loading

- (void)reload { /* Do nothing, subclasses can override. */ }


- (void)reloadSection:(NSInteger)sectionIndex
          withObjects:(NSArray *)objects
{
    // Error checking.
    if (sectionIndex < 0 || sectionIndex >= _sections.count)
        return;
    
    sdmDataSourceSection *section = _sections[sectionIndex];
    section.objects = [objects copy];
}


@end


