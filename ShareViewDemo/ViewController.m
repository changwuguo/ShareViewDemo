//
//  ViewController.m
//  ShareViewDemo
//
//  Created by changwuguo on 2017/1/17.
//  Copyright © 2017年 changwuguo. All rights reserved.
//

#import "ViewController.h"
#import "YYShareView.h"

@interface ViewController () <YYShareViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(0, 0, 60, 60);
    shareBtn.center = self.view.center;
    shareBtn.backgroundColor = [UIColor redColor];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

- (void)shareBtnClick:(UIButton *)shareBtn
{
    YYShareView *shareView = [[YYShareView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    shareView.delegate = self;
    [shareView show];
}

- (void)didSelectShareBtnWithType:(YYShareViewItemType)itemType
{
    switch (itemType) {
        case YYShareViewItemPengYouQuan:
            NSLog(@"分享微信朋友圈");
            break;
        case YYShareViewItemWeChat:
            NSLog(@"分享微信好友");
            break;
        case YYShareViewItemQQ:
            NSLog(@"分享QQ好友");
            break;
        case YYShareViewItemQzone:
            NSLog(@"分享QQ空间");
            break;
        case YYShareViewItemWeibo:
            NSLog(@"分享新浪微博");
            break;
        case YYShareViewItemCopyLink:
            NSLog(@"复制链接");
            break;
        default:
            NSLog(@"其他操作");
            break;
    }
}

@end
