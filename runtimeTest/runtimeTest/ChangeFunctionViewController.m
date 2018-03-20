//
//  ChangeFunctionViewController.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "ChangeFunctionViewController.h"
#import "PerSon.h"
#import "PerSon+changeFunction.h"
@interface ChangeFunctionViewController ()

@end

@implementation ChangeFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initView];

}

- (void)initView{
    
    UIButton *leftBtn  =[[UIButton alloc] initWithFrame:CGRectMake(30, 200, 100, 100)];
    leftBtn.titleLabel.font =[UIFont systemFontOfSize:13];
    [leftBtn setTitle:@"交换自定义的方法" forState:0];
    leftBtn.backgroundColor =[UIColor redColor];
    [leftBtn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn  =[[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    rightBtn.titleLabel.font =[UIFont systemFontOfSize:13];

    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];

    [rightBtn setTitle:@"交换系统方法" forState:0];
    rightBtn.backgroundColor =[UIColor grayColor];
    [self.view addSubview:rightBtn];
    
}
- (void)leftClick:(UIButton*)btn{
    
   PerSon *p =  [[PerSon alloc] init];
    // age 是通过分类添加的属性
    p.age =@"22";
    //调用eat方法后，交换了方法
    [p eat];
}
-(void)rightClick:(UIButton*)btn{
    
    
}
@end
