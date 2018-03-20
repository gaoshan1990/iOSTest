//
//  PerSon+changeFunction.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "PerSon+changeFunction.h"
#import "NSObject+ExchangeFunction.h"
#import <objc/runtime.h>

static  NSString * age  = @"age";

@implementation PerSon (changeFunction)

+(void)load{
    
    [self gs_swizzleClassSelector:@selector(eat) swizzleSelector:@selector(changeEat)];
}

-(void)changeEat{
    
    NSLog(@"狼行千里吃肉========狗行千里吃屎=====");
    
}
//为分类添加属性--------
-(void)setAge:(NSString *)age{
    
    objc_setAssociatedObject(self, &age, age, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)age{
    
    return objc_getAssociatedObject(self, &age);
}
@end
