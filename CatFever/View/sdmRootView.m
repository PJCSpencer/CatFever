//
//  sdmRootView.m
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmRootView.h"


@interface sdmRootView()
{
    UITableView *_tableView;
}
@end





@implementation sdmRootView


#pragma mark - Initializing a View Object (UIView)

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self)
    {
        // Configure.
        self.backgroundColor = [UIColor clearColor];
        
        _tableView = nil;
    }
    return self;
}


#pragma mark - Laying out Subviews (UIView)

- (void)layoutSubviews {
    
    // Super.
    [super layoutSubviews];
    
    // Modify geometry.
    self.tableView.frame = self.bounds;
}


#pragma mark - Property Implementation(s)

- (UITableView *)tableView
{
    if (!_tableView)
    {
        UITableView *anObject = nil;
        anObject = [[UITableView alloc] initWithFrame:CGRectZero
                                                style:UITableViewStylePlain];
        
        anObject.showsVerticalScrollIndicator = NO;
        anObject.separatorColor = [UIColor clearColor];
        anObject.separatorInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
            anObject.layoutMargins = UIEdgeInsetsZero;
        
        // Add subview, assign reference.
        [self addSubview:anObject];
        _tableView = anObject;
    }
    return _tableView;
}


@end


