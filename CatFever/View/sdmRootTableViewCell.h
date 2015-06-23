//
//  sdmRootTableViewCell.h
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRootTableViewCellHeight           256.0f


@interface sdmRootTableViewCell : UITableViewCell

// Property(s).
@property(nonatomic, weak, readonly) UIImageView *imageView;
@property(nonatomic, weak, readonly) UILabel *label;

@end


