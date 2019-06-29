//
//  TrailerViewController.m
//  Flix
//
//  Created by taylorka on 6/28/19.
//  Copyright © 2019 taylorka. All rights reserved.
//

#import "TrailerViewController.h"
#import "WebKit/WebKit.h"

@interface TrailerViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webView;

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Convert the url String to a NSURL object.
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    // Place the URL in a URL Request.
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    // Load Request into WebView.
    [self.webView loadRequest:request];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
