//
//  UIImageView+sdmNetworking.h
//  CatFever
//
//  Created by Peter JC Spencer on 18/06/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (sdmNetworking)

// Setting the image resource.
- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage;

// Functional utility.
- (NSURLRequest *)requestWithURL:(NSURL *)url;

@end


