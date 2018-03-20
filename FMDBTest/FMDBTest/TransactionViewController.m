//
//  Transaction ViewController.m
//  FMDBTest
//
//  Created by most on 2018/1/19.
//  Copyright © 2018年 most. All rights reserved.
//

#import "TransactionViewController.h"
#import "DataBaseTool.h"
@interface TransactionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *transactionLabel;
@property (weak, nonatomic) IBOutlet UILabel *unTransactionLabel;

@end

@implementation TransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}




- (IBAction)useTransaction:(UIButton *)sender {
    
    NSDate  *startDate =[NSDate date];
    [self insertDataUserTransaction:YES];
    NSDate  *endDate =[NSDate date];

    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
  
    self.transactionLabel.text = [NSString stringWithFormat:@"使用事务的时间：%f",time];
}
- (IBAction)unUseTransaction:(UIButton *)sender {
    
    NSDate  *startDate =[NSDate date];

    [self insertDataUserTransaction:NO];
    NSDate  *endDate =[NSDate date];
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    
    self.unTransactionLabel.text = [NSString stringWithFormat:@"不使用事务的时间：%f",time];

}


-(void)insertDataUserTransaction:(BOOL)transaction{
    
    
    FMDatabase  *fmdb  =[DataBaseTool initSqlite];
    
    NSArray *arguments =nil;
    BOOL openDB = [fmdb open];
    
    if (!openDB)  return;
    
    NSString *sql = @"DELETE  FROM  wd_zbxj_dianwei";
    [fmdb executeUpdate:sql];
    
    if (transaction) {
        
        
        @synchronized(self) {
            
            if (openDB) {
                
                [fmdb beginTransaction];
                @try {
                    
                    for (int i =0; i<15000;i++)
                    {
                        
                        NSString *sql =[NSString stringWithFormat:@"INSERT INTO wd_zbxj_dianwei(dianwei_id,dianwei_name,dianwei_type,louceng_name,store_id,store_name,dianwei_address,dianwei_code) values(?,?,?,?,?,?,?,?)"];
                        
                        arguments =@[@"dianwei_id",@"dianwei_name",@"dianwei_type",@"louceng_name",@"store_id",@"store_name",@"dianwei_address",@"dianwei_code"];
                        
                        
                        BOOL insertStatus = [fmdb executeUpdate:sql withArgumentsInArray:arguments];
                        
                        if (!insertStatus) {
                            
                            NSLog(@"%@/n%@",sql,arguments);
                        }
                        
                        
                    }
                }
                
                
                @catch (NSException *exception) {
                    [fmdb rollback];
                }
                @finally {
                    [fmdb commit];
                    [fmdb close];
                    
                }
                
            }
            
        }
    }else{
        
        for (int i =0; i<500;i++)
        {
            
            
            NSString *sql =[NSString stringWithFormat:@"INSERT INTO wd_zbxj_dianwei(dianwei_id,dianwei_name,dianwei_type,louceng_name,store_id,store_name,dianwei_address,dianwei_code) values(?,?,?,?,?,?,?,?)"];
            
            arguments =@[@"dianwei_id",@"dianwei_name",@"dianwei_type",@"louceng_name",@"store_id",@"store_name",@"dianwei_address",@"dianwei_code"];
            
            
            [fmdb executeUpdate:sql withArgumentsInArray:arguments];
        }
    }
}

@end

