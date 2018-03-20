//
//  UIButton+changeFunction.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "UIButton+changeFunction.h"
#import "NSObject+ExchangeFunction.h"
@implementation UIButton (changeFunction)
+ (void)load{
    
//    [self gs_swizzleClassSelector:@selector(addTarget:action:forControlEvents:) swizzleSelector:@selector(gs_addTarget:action:forControlEvents:)];
}


-(void)gs_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    
    NSLog(@"交换了button的点击");
}
@end
