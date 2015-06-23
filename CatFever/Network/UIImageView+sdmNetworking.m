//
//  UIImageView+sdmNetworking.m
//  CatFever
//
//  Created by Peter JC Spencer on 18/06/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "UIImageView+sdmNetworking.h"

#import <objc/runtime.h>


@interface UIImageView (_sdmNetworking) // Private ivar.

// Property(s).
@property(nonatomic, strong) NSURLSessionDataTask *associatedTask;

@end





@implementation UIImageView (_sdmNetworking)


#pragma mark - 

@dynamic associatedTask;


#pragma mark - Property Implementation(s)

- (NSURLSessionDataTask *)associatedTask
{
    return (NSURLSessionDataTask *)objc_getAssociatedObject(self, @selector(associatedTask));
}


- (void)setAssociatedTask:(NSURLSessionDataTask *)newObject
{
    objc_setAssociatedObject(self,
                             @selector(associatedTask),
                             newObject,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end





@implementation UIImageView (sdmNetworking)


#pragma mark - Setting the Image Resource

- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholderImage
{
    NSURLRequest *request = [self requestWithURL:url];
    NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    __weak UIImageView *weakSelf = self;
    
    // Has a response been cached?
    if (cachedResponse)
        dispatch_async(dispatch_get_main_queue(), ^ { /* NB: Removes very slight but noticeable stutter. */
            
            weakSelf.image = [UIImage imageWithData:cachedResponse.data];
        });
    
    // TODO: Support reachability ...
    
    
    else if (![self.associatedTask.originalRequest.URL isEqual:url])
    {
        // Cancel task.
        [self.associatedTask cancel];
        self.associatedTask = nil;
        
        // Configure GUI.
        self.image = placeholderImage;
        
        __weak NSURLCache *weakCache = [NSURLCache sharedURLCache];
        
        // Create new task.
        self.associatedTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                              completionHandler:^(NSData *data,
                                                                                  NSURLResponse *response,
                                                                                  NSError *error)
                               {
                                   NSInteger status = ((NSHTTPURLResponse *)response).statusCode; // TODO: Cast object ...
                                   
                                   // Error checking and status validation.
                                   if (!error && status == 200)
                                   {
                                       NSURLCacheStoragePolicy policy = ([response.URL.scheme isEqualToString:@"http"] /* TODO: Define constant(s) ... */
                                                                         ? NSURLCacheStorageAllowed
                                                                         : NSURLCacheStorageAllowedInMemoryOnly);
                                       
                                       // Store the resource.
                                       NSCachedURLResponse *cachedResponse = nil;
                                       cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response
                                                                                                 data:data
                                                                                             userInfo:nil
                                                                                        storagePolicy:policy];
                                       
                                       [weakCache storeCachedResponse:cachedResponse forRequest:request];
                                       
                                       // Update GUI.
                                       dispatch_async(dispatch_get_main_queue(), ^ {
                                           
                                           weakSelf.image = [UIImage imageWithData:data];
                                       });
                                   }
                               }];
        
        // Load resource.
        [self.associatedTask resume];
    }
}


#pragma mark - Functional Utility

- (NSURLRequest *)requestWithURL:(NSURL *)url
{
    NSMutableURLRequest *request = nil;
    request = [NSMutableURLRequest requestWithURL:url
                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                  timeoutInterval:30];
    request.allowsCellularAccess = NO;
    
    return (NSURLRequest *)request;
}


@end


