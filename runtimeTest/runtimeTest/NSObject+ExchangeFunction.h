//
//  NSObject+ExchangeFunction.h
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ExchangeFunction)
+ (void)gs_swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector;
//字典转模型
+ (instancetype)modelWithDict:(NSDictionary *)dict;
@end
