//
//  DataBaseTool.h
//  FMDBTest
//
//  Created by most on 2018/1/19.
//  Copyright © 2018年 most. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface DataBaseTool : NSObject
+(FMDatabase *)initSqlite;
@end
