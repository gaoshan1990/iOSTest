//
//  DataBaseTool.m
//  FMDBTest
//
//  Created by most on 2018/1/19.
//  Copyright © 2018年 most. All rights reserved.
//

#import "DataBaseTool.h"
@implementation DataBaseTool
+(FMDatabase *)initSqlite{
    
    FMDatabase *fmdb = [FMDatabase databaseWithPath:[self sqlitePath]];
    
    return fmdb;
    
}
//获取数据库路径
+(NSString*)sqlitePath{
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *fullPath =[docDir stringByAppendingPathComponent:@"sqlite.db"];
    
    NSFileManager  *mgr = [NSFileManager defaultManager];
    
    if(![mgr fileExistsAtPath:fullPath]) {
        
        //1. 创建数据库路径

//        [mgr createFileAtPath:fullPath contents:nil attributes:nil];
        
        //2. 从buddle中复制到沙盒中
        NSString *buddlePath =[[NSBundle mainBundle] pathForResource:@"sqlite" ofType:@"db"];
        
        [mgr copyItemAtPath:buddlePath toPath:fullPath error:nil];
        
        NSLog(@"第一次创建=====%@",fullPath);
        
        return fullPath;
    }
    NSLog(@"从沙盒中取=====%@",fullPath);

    return  fullPath;
}
@end
