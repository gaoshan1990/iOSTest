//
//  FMDBTestTableviewController.m
//  FMDBTest
//
//  Created by most on 2018/1/19.
//  Copyright © 2018年 most. All rights reserved.
//

#import "FMDBTestTableviewController.h"
#import "DataBaseTool.h"
#import "OperateViewController.h"
#import "TransactionViewController.h"
@interface FMDBTestTableviewController ()
@property(nonatomic,strong) NSArray *cellArray;
@end

@implementation FMDBTestTableviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title =@"FMDB使用";
    self.cellArray =@[@"建立数据库",@"数据库操作",@"数据库事务"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.cellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fmdbCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fmdbCell"];
    }
    cell.textLabel.text =self.cellArray [indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.创建数据库
    if (indexPath.row==0) {
        
        FMDatabase  *fmdb  =[DataBaseTool initSqlite];
        NSLog(@"%@",fmdb);

    }else if (indexPath.row==1) {
        

        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"OperateFMDB" bundle:nil];
        
        UIViewController *OperateViewController = [story instantiateViewControllerWithIdentifier:@"OperateFMDB"];
    [self.navigationController pushViewController:OperateViewController animated:YES];
        
//
        
    }else if (indexPath.row==2) {
        
        TransactionViewController *transationVc =[[TransactionViewController alloc] initWithNibName:@"TransactionViewController" bundle:nil];
        [self.navigationController pushViewController:transationVc animated:YES];
    }
    
}


@end
