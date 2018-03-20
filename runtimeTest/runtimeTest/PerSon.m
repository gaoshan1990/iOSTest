//
//  PerSon.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "PerSon.h"
#import <objc/runtime.h>
@implementation PerSon
-(void)eat{
    
    NSLog(@"是人就要吃饭======哈哈哈");
    
}

// void(*)()

// 默认方法都有两个隐式参数，

void run(id self,SEL sel)

{
    
    NSLog(@"动态添加了方法========%@ %@",self,NSStringFromSelector(sel));
    
}



// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.

// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法

+ (BOOL)resolveInstanceMethod:(SEL)sel

{
    
    if (sel == @selector(run)) {
        
        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        
        // 第二个参数：添加方法的方法编号
        
        // 第三个参数：添加方法的函数实现（函数地址）
        
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        
        class_addMethod(self, @selector(run), (IMP)run, "v@:");
        
        
        
    }
    
    
    
    return [super resolveInstanceMethod:sel];
    
}
@end
