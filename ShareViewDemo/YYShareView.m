//
//  YYShareView.m
//  ShareViewDemo
//
//  Created by changwuguo on 2017/1/17.
//  Copyright © 2017年 changwuguo. All rights reserved.
//

#import "YYShareView.h"
#import "YYShareButton.h"

/** 默认高度*/
static const CGFloat kSelfHeight = 300;

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@interface YYShareView ()
{
    // 顶部视图item数量
    NSInteger _topShareItemCount;
}

/** 分享视图*/
@property (nonatomic, strong) UIView *shareView;

@end

@implementation YYShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        [self setUp];
    }
    
    return self;
}

#pragma mark - 创建UI
- (void)setUp
{
    // 背景Btn
    UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bgBtn.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kSelfHeight);
    [bgBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgBtn];
    
    // 分享视图
    self.shareView = ({
        UIView *shareView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kSelfHeight)];
        shareView.backgroundColor = RGBColor(240, 240, 240);
        [self addSubview:shareView];
        shareView;
    });
    
    // 上ScrollView
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 126)];
    topScrollView.tag = 1;
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.backgroundColor = RGBColor(240, 240, 240);
    [self.shareView addSubview:topScrollView];
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(topScrollView.frame) + 2, kScreenWidth - 20 * 2, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.shareView addSubview:lineView];
    
    // 下ScrollView
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView.frame) + 2, kScreenWidth, 126)];
    bottomScrollView.tag = 2;
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    bottomScrollView.backgroundColor = RGBColor(240, 240, 240);
    [self.shareView addSubview:bottomScrollView];
    
    // 关闭Btn
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, CGRectGetMaxY(bottomScrollView.frame), kScreenWidth, 44);
    closeBtn.backgroundColor = [UIColor whiteColor];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [closeBtn setTitle:@"取消" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:closeBtn];
    
    // 设置数据
    [self setDataSourceWithTopScrollView   :topScrollView];
    [self setDataSourceWithBottomScrollView:bottomScrollView];
}

#pragma mark - TopScrollView设置数据
- (void)setDataSourceWithTopScrollView:(UIScrollView *)scrollView
{
    NSArray *imageArr1 = @[@"alishq_allshare_60x60_",
                           @"weixin_allshare_60x60_",
                           @"qq_allshare_60x60_",
                           @"qqkj_allshare_60x60_",
                           @"sina_allshare_60x60_",
                           @"qqwb_allshare_60x60_",
                           @"aliplay_allshare_60x60_",
                           @"alishq_allshare_60x60_"
                           ];
    
    NSArray *titleArr1 = @[@"微信朋友圈",
                           @"微信好友",
                           @"手机QQ",
                           @"QQ空间",
                           @"新浪微博",
                           @"腾讯微博",
                           @"支付宝好友",
                           @"支付宝生活圈"
                           ];
    
    _topShareItemCount = imageArr1.count;
    
    [self setScrollViewContentWithScrollView:scrollView imgArray:imageArr1 titleArray:titleArr1];
}

#pragma mark - BottomScrollView设置数据
- (void)setDataSourceWithBottomScrollView:(UIScrollView *)scrollView
{
    NSArray *imgArr2   = @[@"airdrop_allshare_60x60_",
                           @"link_allshare_60x60_",
                           @"mail_allshare_60x60_",
                           @"copy_allshare_60x60_"
                           ];
    
    NSArray *titleArr2 = @[@"系统分享",
                           @"信息",
                           @"邮件",
                           @"复制链接"
                           ];
    [self setScrollViewContentWithScrollView:scrollView imgArray:imgArr2 titleArray:titleArr2];
}

#pragma mark - ScrollView设置数据
- (void)setScrollViewContentWithScrollView:(UIScrollView *)scrollView imgArray:(NSArray *)imgArray titleArray:(NSArray *)titleArray
{
    CGFloat btnW = 76;
    CGFloat btnH = 90;
    CGFloat btnX = 0;
    CGFloat btnY = scrollView.tag == 1 ? 23 : 15;
    CGFloat margin = 18;
    
    for (int i = 0; i < imgArray.count; i++) {
        
        btnX = btnW * i + margin;
        
        YYShareButton *shareItem = [YYShareButton buttonWithType:UIButtonTypeCustom];
        shareItem.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [shareItem setImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        [shareItem setTitle:titleArray[i] forState:UIControlStateNormal];
        [shareItem addTarget:self action:@selector(shareItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:shareItem];
        
        if (i == imgArray.count - 1) {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(shareItem.frame) + margin, btnH);
        }
        
        if (scrollView.tag == 1) {
            shareItem.tag = i + 1;
        }
        else {
            shareItem.tag = i + 1 + _topShareItemCount;
        }
    }
}

- (void)shareItemClick:(YYShareButton *)shareItemBtn
{
    YYShareViewItemType itemType = YYShareViewItemOther;
    
    if (shareItemBtn.tag == 1) {
        itemType = YYShareViewItemPengYouQuan;
    }
    else if (shareItemBtn.tag == 2) {
        itemType = YYShareViewItemWeChat;
    }
    else if (shareItemBtn.tag == 3) {
        itemType = YYShareViewItemQQ;
    }
    else if (shareItemBtn.tag == 4) {
        itemType = YYShareViewItemQzone;
    }
    else if (shareItemBtn.tag == 5) {
        itemType = YYShareViewItemWeibo;
    }
    else if (shareItemBtn.tag == 11) {
        itemType = YYShareViewItemCopyLink;
    }
    else {
        itemType = YYShareViewItemOther;
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectShareBtnWithType:)]) {
        [self.delegate didSelectShareBtnWithType:itemType];
    }
}

// 显示
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    NSTimeInterval i     = 0;
    NSTimeInterval delay = 0;

    for (UIView *subView in self.shareView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            UIScrollView *scrollView = (UIScrollView *)subView;
            
            for (UIView *subView in scrollView.subviews) {
                if ([subView isKindOfClass:[YYShareButton class]]) {
                    if (i == 5) {
                        delay = 0;
                    }
                    delay += 0.04;
                    i += 1;
                    
                    YYShareButton *shareBtn = (YYShareButton *)subView;
                    [shareBtn shakeBtnWithDely:delay];
                }
            }
        }
    }
    
    self.alpha = 0.0f;
    
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 1.0f;
        self.shareView.frame = CGRectMake(0, kScreenHeight - kSelfHeight, kScreenWidth, kSelfHeight);
    }];
}

// 关闭
- (void)dismiss
{
    [UIView animateWithDuration:0.2f animations:^{
        self.shareView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kSelfHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    NSLog(@"%@ -- dealoc", NSStringFromClass([self class]));
}

@end
