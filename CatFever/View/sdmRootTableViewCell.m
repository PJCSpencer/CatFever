//
//  sdmRootTableViewCell.m
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmRootTableViewCell.h"


@interface sdmRootTableViewCell()
{
    UIImageView *_imageView;
    UILabel *_label;
}
@end





@implementation sdmRootTableViewCell


#pragma mark - Initializing a UITableViewCell Object (UITableViewCell)

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Configure.
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _imageView = nil;
        _label = nil;
    }
    return self;
}


#pragma mark - Laying out Subviews (UIView)

- (void)layoutSubviews {
    
    // Super.
    [super layoutSubviews];
    
    // Modify geometry.
    CGSize borderSize = CGSizeMake(12.0f, 12.0f);
    CGFloat textPadding = 4.0f;
    CGFloat textHeight = [self.label.text boundingRectWithSize:CGSizeMake(self.bounds.size.width, CGFLOAT_MAX)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{ NSFontAttributeName : self.label.font }
                                                       context:nil].size.height;
    textHeight += (textPadding * 2.0f);
    
    self.label.frame = CGRectMake(borderSize.width,
                                  self.contentView.bounds.size.height - (borderSize.height + textHeight),
                                  self.contentView.bounds.size.width - (borderSize.width * 2.0f),
                                  textHeight);
    
    self.imageView.frame = CGRectMake(borderSize.width,
                                      borderSize.height,
                                      self.contentView.bounds.size.width - (borderSize.width * 2.0f),
                                      self.contentView.bounds.size.height - (borderSize.height * 2.0f + textHeight) + 1.0f);
    
    // Order.
    [self.contentView bringSubviewToFront:self.label];
}


#pragma mark - Property Implementation(s)

- (UIImageView *)imageView
{
    if (!_imageView)
    {
        UIImageView *anObject = nil;
        anObject = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        anObject.clipsToBounds = YES;
        anObject.contentMode = UIViewContentModeScaleAspectFill;
        anObject.backgroundColor = [UIColor cyanColor];
        
        // Add subview, assign reference.
        [self.contentView addSubview:anObject];
        _imageView = anObject;
    }
    return _imageView;
}


- (UILabel *)label
{
    if (!_label)
    {
        UILabel *anObject = nil;
        anObject = [[UILabel alloc] initWithFrame:CGRectZero];
        
        anObject.adjustsFontSizeToFitWidth = YES;
        anObject.font = [UIFont boldSystemFontOfSize:13.0f];
        anObject.textAlignment = NSTextAlignmentCenter;
        anObject.backgroundColor = [UIColor blackColor];
        anObject.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:anObject];
        _label = anObject;
    }
    return _label;
}


@end


