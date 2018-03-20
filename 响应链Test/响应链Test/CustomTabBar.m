//
//  CustomTabBar.m
//  响应链Test
//
//  Created by most on 2018/3/15.
//  Copyright © 2018年 most. All rights reserved.
//

#import "CustomTabBar.h"



@interface CustomTabBar()
@property (nonatomic, weak) UIButton *publishButton;

@end
@implementation CustomTabBar
- (UIButton *)publishButton
{
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        publishButton.backgroundColor  =[UIColor redColor];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    /**** 按钮的尺寸 ****/
    CGFloat buttonW = self.bounds.size.width / 5;
    CGFloat buttonH = self.bounds.size.height;
    
    /**** 设置所有UITabBarButton的frame ****/
    CGFloat tabBarButtonY = 0;
    // 按钮索引
    int tabBarButtonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        
        NSLog(@"======%@",self.subviews);
        // 过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat tabBarButtonX = tabBarButtonIndex * buttonW;
        if (tabBarButtonIndex >= 2) { // 右边的2个UITabBarButton
            tabBarButtonX += buttonW;
        }
        subview.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        
        // 增加索引
        tabBarButtonIndex++;
        
      
    }
    
    /**** 设置中间的发布按钮的frame ****/
    
    CGRect temp  =self.publishButton.bounds;
    temp.size.width  =buttonW;
    temp.size.height = buttonH*3;
    
    self.publishButton.bounds =temp;
    self.publishButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
}
#pragma mark - 监听
- (void)publishClick
{
 
    NSLog(@"%@",NSStringFromCGRect(self.publishButton.frame));
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    //1.将tabBar的坐标转换到按钮上
    
    CGPoint  newP =  [self convertPoint:point toView:self.publishButton];
    
    
    if ([self.publishButton pointInside:newP withEvent:event]) {
        return self.publishButton;
    }else{
        
        return [super hitTest:point withEvent:event];
    }
    
    return self.publishButton;
    
}
@end
