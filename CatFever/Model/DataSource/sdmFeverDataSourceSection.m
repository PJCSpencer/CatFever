//
//  sdmFeverDataSourceSection.m
//  CatFever
//
//  Created by Peter JC Spencer on 17/06/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmFeverDataSourceSection.h"

#import "sdmRootTableViewCell.h"
#import "UIImageView+sdmNetworking.h"


@implementation sdmFeverDataSourceSection


#pragma mark -

- (NSString *)reuseIdentifier
{
    static NSString *anObject = nil;
    if (!anObject)
        anObject = @"com.spencers-dm.catFever.dataSourceSection.fever";
    
    return anObject;
}


- (id)cell
{
    sdmRootTableViewCell *anObject = nil;
    anObject = [[sdmRootTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:self.reuseIdentifier];
    
    anObject.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return anObject;
}


- (CGFloat)heightForCellAtIndex:(NSInteger)index
{
    return kRootTableViewCellHeight;
}


#pragma mark -

- (void)modifyCell:(id)cell withObjectAtIndex:(NSInteger)index
{
    NSDictionary *data = self.objects[index];
    if (data)
    {
        ((sdmRootTableViewCell *)cell).label.text = data[@"source_url"];
        [((sdmRootTableViewCell *)cell).imageView setImageWithURL:[NSURL URLWithString:data[@"url"]]
                                                 placeholderImage:nil]; // TODO: Support placeholder ...
    }
}


@end


