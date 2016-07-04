//
//  FreeWalkListViewController.m
//  Travel
//
//  Created by qf1 on 16/2/17.
//  Copyright (c) 2016年 qf1. All rights reserved.
//

#import "FreeWalkListViewController.h"

@interface FreeWalkListViewController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation FreeWalkListViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];

}

#pragma mark - 创建UI
- (void)createUI
{
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_webViewUrl]];
    
    [_webView loadRequest:request];
    
    [self.view addSubview:_webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end



















