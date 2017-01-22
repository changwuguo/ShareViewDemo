//
//  YYShareView.h
//  ShareViewDemo
//
//  Created by changwuguo on 2017/1/17.
//  Copyright © 2017年 changwuguo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YYShareViewItemType) {
    YYShareViewItemWeChat,      // 微信
    YYShareViewItemPengYouQuan, // 朋友圈
    YYShareViewItemQQ,          // QQ
    YYShareViewItemQzone,       // QQ控件
    YYShareViewItemWeibo,       // 新浪微博
    YYShareViewItemCopyLink,    // 复制链接
    YYShareViewItemOther        // 其他
};

@protocol YYShareViewDelegate <NSObject>

@required
- (void)didSelectShareBtnWithType:(YYShareViewItemType)itemType;

@end

@interface YYShareView : UIView

@property (nonatomic, weak) id<YYShareViewDelegate> delegate;

/** 显示视图*/
- (void)show;

/** 关闭视图*/
- (void)dismiss;

@end
