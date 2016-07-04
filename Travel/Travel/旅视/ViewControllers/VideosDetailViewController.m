//
//  VideosDetailViewController.m
//  Travel
//
//  Created by qf1 on 16/2/5.
//  Copyright (c) 2016年 qf1. All rights reserved.
//
#import "VideosDetailModel.h"
#import "VideosDetailModel+Net.h"
#import "DetailView.h"
#import "JRPlayerViewController.h"
#import "VideosDetailViewController.h"

@interface VideosDetailViewController ()

@property (nonatomic, strong) DetailView *detailView;
@end

@implementation VideosDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removePanGesture" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    [self createUI];
}


#pragma mark - 获取数据
- (void)getData
{
    [VideosDetailModel requestVideosDetailModelWithUrl:_url compltionBlock:^(VideosDetailModel *VideosDetailModel, NSError *error) {
        
        if (error == nil) {
            
            [_detailView setDataWithModel:VideosDetailModel target:self action:@selector(goToVideosWithModel:tag:)];
    
//            NSLog(@"旅视详情获取数据成功");
        } else {
            NSLog(@"旅视详情获取数据失败");
        }
        
    }];
}


#pragma mark - 创建UI
- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    // 设置自定义滚动视图
    _detailView = [[DetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    
    [self.view addSubview:_detailView];
    
}


#pragma mark - 事件响应
- (void)goToVideosWithModel:(VideosDetailModel *)model tag:(NSNumber *)tag
{
    NSInteger num = [tag integerValue];
    if (num == 100) {
        // 视频播放
        JRPlayerViewController *jrVc = [[JRPlayerViewController alloc] initWithHTTPLiveStreamingMediaURL:[NSURL URLWithString:model.videoHref]];
        jrVc.mediaTitle = model.name;
        [self presentViewController:jrVc animated:YES completion:nil];
 
    } else {
        
        //集成新浪微博，微信和QQ
        [UMSocialSnsService presentSnsIconSheetView:self appKey:@"53f5a6a6fd98c50d6b0029d3" shareText:model.videoHref shareImage:[UIImage imageNamed:@""] shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToRenren,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,nil] delegate:nil];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end




























