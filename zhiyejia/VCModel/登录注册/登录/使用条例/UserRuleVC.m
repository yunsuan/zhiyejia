//
//  UserRuleVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/17.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "UserRuleVC.h"
#import <WebKit/WebKit.h>

@interface UserRuleVC ()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation UserRuleVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.titleLabel.text = @"使用条例";
    
    _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT)];
    _wkWebView.navigationDelegate = self;
    _wkWebView.userInteractionEnabled = NO;
        
        
    [self.view addSubview:_wkWebView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.goodhome.net.cn/web/html/user_protocol.html"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    [_wkWebView loadRequest:request];
}

@end
