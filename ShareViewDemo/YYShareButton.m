//
//  YYShareButton.m
//  ShareViewDemo
//
//  Created by changwuguo on 2017/1/17.
//  Copyright © 2017年 changwuguo. All rights reserved.
//

#import "YYShareButton.h"

@implementation YYShareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.image) {
        self.imageView.frame = CGRectMake((self.bounds.size.width - self.imageView.image.size.width) / 2.0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
    }
    
    if (self.titleLabel.text) {
        self.titleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 7.0, self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.imageView.frame) - 7.0);
    }
}

- (void)shakeBtnWithDely:(NSTimeInterval)dely
{
    CGAffineTransform top1    = CGAffineTransformMakeTranslation(0, 100);
    CGAffineTransform top2    = CGAffineTransformMakeTranslation(0, -8);
    CGAffineTransform bottom1 = CGAffineTransformMakeTranslation(0, 3);
    CGAffineTransform reset   = CGAffineTransformIdentity;
    
    // 0 初始状态
    self.transform = top1;
    self.alpha = 0.3f;
    
    // 1 向上
    [UIView animateWithDuration:0.2f delay:dely options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.alpha = 1.0f;
        self.transform = top2;
        
    } completion:^(BOOL finished) {
        // 2 向下
        [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.transform = bottom1;
            
        } completion:^(BOOL finished) {
            //3 还原
            [UIView animateWithDuration:0.15f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                self.transform = reset;
                
            } completion:nil];
        }];
    }];
}

@end
