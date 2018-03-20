//
//  ViewController.m
//  KVC&&KVOTest
//
//  Created by most on 2018/3/20.
//  Copyright © 2018年 most. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
/*
 
 @property(nonatomic,strong) NSString * title;
 @property(nonatomic,strong) NSString * name;
 @property(nonatomic,strong) NSString * leve;
 @property(nonatomic,strong) NSString * icon;
 @property(nonatomic,strong) NSString * img;
 
 */

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSDictionary *dict =@{ @"title":@"测试",
                           @"name":@"这个是name",
                           @"leve":@"层次",
                           @"icon":@"头像",
                           @"img":@"图片"};
    
    TestModel *model =[[TestModel alloc]init];
    
    //1. 字典转model
    [model testModelWithDict:dict];
    
    NSArray * array =@[@"title",@"name",@"leve",@"icon",@"img"];
    
    //2. model 转字典
    NSDictionary *dict2 =  [model modelToDictWithArray:array];
    
    NSLog(@"%@",dict2);
    
    //3. 修改私有属性
    [model setValue:@"修改属性" forKey:@"_privateExtension"];
    
    NSLog(@"%@",[model valueForKey:@"_privateExtension"]);

}


@end
