//
//  sdmRootController.m
//  CatFever
//
//  Created by Peter JC Spencer on 19/05/2015.
//  Copyright (c) 2015 Spencer's digital media. All rights reserved.
//

#import "sdmRootController.h"

#import "sdmRootView.h"
#import "sdmTableViewDataSource.h"


@interface sdmRootController () <NSXMLParserDelegate>
{
    NSMutableDictionary *_xmlElement;
    NSString *_xmlElementValue;
    NSMutableArray *_xmlResults;
}
@end





@implementation sdmRootController


#pragma mark - Creating a View Controller Using Nib Files (UIViewController)

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _xmlElement = nil;
        _xmlElementValue = nil;
        _xmlResults = [[NSMutableArray alloc] initWithCapacity:0];
        
        _dataSource = nil;
    }
    return self;
}


#pragma mark - Property Implementation(s)

- (void)setDataSource:(sdmTableViewDataSource *)newObject
{
    if ([newObject isKindOfClass:[sdmTableViewDataSource class]])
    {
        _dataSource = newObject;
        _dataSource.tableView = ((sdmRootView *)self.view).tableView;
    }
    else
    {
        _dataSource = nil;
        [((sdmRootView *)self.view).tableView reloadData];
    }
}


#pragma mark - Managing the View (UIViewController)

- (void)loadView {

    CGRect rect = CGRectMake(0.0f,
                             0.0f,
                             [UIScreen mainScreen].bounds.size.width,
                             [UIScreen mainScreen].bounds.size.height);
    
    sdmRootView *root = nil;
    root = [[sdmRootView alloc] initWithFrame:rect];
    self.view = root;
}


#pragma mark - Responding to View Events (UIViewController)

- (void)viewDidAppear:(BOOL)animated {
    
    // Super.
    [super viewDidAppear:animated];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Interface" ofType:@"json"];
    
    // Assign reference.
    __weak sdmRootController *weakSelf = self;
    weakSelf.dataSource = [[sdmTableViewDataSource alloc] initWithContentsOfJSONAtPath:path];
    
    // Request API data.
    NSString *string = @"http://thecatapi.com/api/images/get?format=xml&type=jpg&size=med&category=sunglasses&results_per_page=50";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      NSString *contentType = ((NSHTTPURLResponse *)response).allHeaderFields[@"Content-Type"];
                                      
                                      if ([contentType isEqualToString:@"text/xml"])
                                      {
                                          NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
                                          parser.delegate = weakSelf;
                                          
                                          // Flush.
                                          [_xmlResults removeAllObjects];
                                          
                                          BOOL success = [parser parse];
                                          if (success)
                                              dispatch_async(dispatch_get_main_queue(), ^ {

                                                  [weakSelf.dataSource reloadSection:0
                                                                         withObjects:_xmlResults];
                                              });
                                      }
                                  }];
    [task resume];
}


#pragma mark - NSXMLParserDelegate Protocol

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"image"]) // TODO: Define key constant(s) ...
        _xmlElement = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                       @"http://www.whatever.com/apps/media/image/placeholder.png", @"url",
                       @"Undefined", @"source_url",
                       nil];
    
    _xmlElementValue = _xmlElement[elementName];
}


- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
    if (_xmlElementValue) _xmlElementValue = string;
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (_xmlElementValue)
        _xmlElement[elementName] = _xmlElementValue;
    
    if ([elementName isEqualToString:@"image"])
        [_xmlResults addObject:[NSDictionary dictionaryWithDictionary:_xmlElement]];
}


@end


