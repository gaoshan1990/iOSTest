//
//  TestTableViewController.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "TestTableViewController.h"

@interface TestTableViewController ()
@property(nonatomic,strong) NSArray *cellArray;
@property(nonatomic,strong) NSArray *controllerArray;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.cellArray =@[@"交换方法",@"分类加属性",@"动态添加方法",@"字典转模型",@"修改系统控件的私有属性"];
    self.controllerArray =@[@"ChangeFunctionViewController",@"AddPropetyViewController",@"AddFunctionViewController",@"DictionToModelViewController",@"ModifyPrivatePropetyViewController"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.cellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTest"];
    
    if (!cell) {
        cell  =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellTest"];
        
    }
    cell.textLabel.text =  [self.cellArray objectAtIndex:indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Class  clss  =  NSClassFromString(self.controllerArray[indexPath.row]);
    
     UIViewController *vc = [[clss alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
