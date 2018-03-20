//
//  CustomTabBarController.m
//  响应链Test
//
//  Created by most on 2018/3/15.
//  Copyright © 2018年 most. All rights reserved.
//

#import "CustomTabBarController.h"
#import "TestViewControllerOne.h"
#import "TestViewControllerTwo.h"
#import "TestViewControllerThree.h"
#import "CustomTabBar.h"
@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setValue:[[CustomTabBar alloc] init] forKey:@"tabBar"];

    
    
    TestViewControllerOne  *one  =[[TestViewControllerOne alloc] init];
    
    one.title  =@"one";
    [self addChildViewController:one];
    
    TestViewControllerTwo  *two =[[TestViewControllerTwo alloc] init];
    two.title  =@"two";
 
    
    
    [self addChildViewController:two];
    
    TestViewControllerThree  *three =[[TestViewControllerThree alloc] init];
    three.title  =@"three";

    [self addChildViewController:three];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
