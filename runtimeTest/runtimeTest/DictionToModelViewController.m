//
//  DictionToModelViewController.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "DictionToModelViewController.h"
#import "NSObject+ExchangeFunction.h"
#import "Model.h"
@interface DictionToModelViewController ()

@end

@implementation DictionToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     
     @property(nonatomic,strong)NSString *name;
     @property(nonatomic,strong)NSString *score;
     @property(nonatomic,strong)NSString *nick;
     @property(nonatomic,strong)NSString *title;
     @property(nonatomic,strong)NSString *url;

     */
   
    
    Model   *model  =[Model modelWithDict:@{@"name":@"Test",@"score":@"111",@"nick":@"Hello",@"title11":@"测试"}];
    
    NSLog(@"%@",model);
    
    // Do any additional setup after loading the view.
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
