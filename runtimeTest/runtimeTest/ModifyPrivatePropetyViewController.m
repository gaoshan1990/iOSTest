//
//  ModifyPrivatePropetyViewController.m
//  runtimeTest
//
//  Created by most on 2018/3/20.
//  Copyright © 2018年 most. All rights reserved.
//

#import "ModifyPrivatePropetyViewController.h"
#import <objc/runtime.h>
@interface ModifyPrivatePropetyViewController ()
@end

@implementation ModifyPrivatePropetyViewController
/*
 利用runtime 修改私有属性
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initPageControl];
    [self getAllProperties];
}

-(void)initPageControl{
    
    UIPageControl * pageControl = [[UIPageControl alloc]init];
    pageControl.frame =CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height);
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPageIndicatorTintColor =[UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self.view addSubview:pageControl];
    
    
    // 使用kvc 改变系统的私有属性
    [pageControl setValue:[UIImage imageNamed:@"wancheng"] forKeyPath:@"_pageImage"];
    
    [pageControl setValue:[UIImage imageNamed:@"weikaishi"] forKeyPath:@"_currentPageImage"];
}

- (NSArray*)getAllProperties{
    
    unsigned int count;
    
    NSMutableArray *propertiesArray = [NSMutableArray array];
    
    // 获取成员变量：
        Ivar * ivars = class_copyIvarList([UIPageControl class], &count);
        
        for (unsigned int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            const char * type = ivar_getTypeEncoding(ivar);
            
            NSLog(@"Person拥有的成员变量的类型为%s，名字为 %s ",type, name);
            [propertiesArray addObject: [NSString stringWithUTF8String:name]];

        }
        
        free(ivars);

    
    return propertiesArray;
    
}

@end
