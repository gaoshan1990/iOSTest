//
//  NSObject+ExchangeFunction.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "NSObject+ExchangeFunction.h"
#import <objc/runtime.h>

@implementation NSObject (ExchangeFunction)
+ (void)gs_swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector{
    
    Method  originalSel  = class_getInstanceMethod(self, origSelector);
    
    Method  currentSel   =class_getInstanceMethod(self, swizzleSelector);
    
    BOOL isAdd = class_addMethod(self,origSelector, method_getImplementation(currentSel), method_getTypeEncoding(currentSel));
    
    if (!isAdd) { // 添加方法失败，表示原有方法存在，直接替换
        method_exchangeImplementations(originalSel, currentSel);
    }else{
        
        class_replaceMethod(self, origSelector, method_getImplementation(currentSel), method_getTypeEncoding(currentSel));
    }
    
    
}
+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    id objc = [[self alloc] init];
    
    // runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
    // 1.获取模型中所有成员变量 key
    // 获取哪个类的成员变量
    // count:成员变量个数
    unsigned int count = 0;
    // 获取成员变量数组
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 遍历所有成员变量
    for (int i = 0; i < count; i++) {
        // 获取成员变量
        Ivar ivar = ivarList[i];
        
        // 获取成员变量名字
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取成员变量类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        // @\"User\" -> User
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        // 获取key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 去字典中查找对应value
        // key:user  value:NSDictionary
        
        id value = dict[key];
        
        // 二级转换:判断下value是否是字典,如果是,字典转换层对应的模型
        // 并且是自定义对象才需要转换
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType hasPrefix:@"NS"]) {
            // 字典转换成模型 userDict => User模型
            // 转换成哪个模型
            
            // 获取类
            Class modelClass = NSClassFromString(ivarType);
            
            value = [modelClass modelWithDict:value];
        }
        
        // 给模型中属性赋值
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    return objc;
}
@end
