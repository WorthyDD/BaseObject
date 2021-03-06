//
//  BaseWebViewController.m
//  EmployeeAssistant
//
//  Created by 武淅 段 on 16/9/9.
//  Copyright © 2016年 xxkuaipao. All rights reserved.
//

#import "BaseWebViewController.h"
#import <KVNProgress.h>

@interface BaseWebViewController ()<UIWebViewDelegate>

@property (nonatomic) UIWebView *webView;
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    if(_urlString){
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]];
        [_webView loadRequest:request];
        [KVNProgress show];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [KVNProgress dismiss];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('title')[0].innerHTML;"];
    if(title.length){
        self.title = title;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error---%@", error);
}


@end
