//
//  TestModel.m
//  KVC&&KVOTest
//
//  Created by most on 2018/3/20.
//  Copyright © 2018年 most. All rights reserved.
//

#import "TestModel.h"
@interface TestModel()
@property(nonatomic,strong) NSString *privateExtension;
@end
@implementation TestModel


-(instancetype)init{
    
    if (self =[super init]) {
        
        self.privateExtension =@"Test";
    }
    
    return self;
}
-(instancetype)testModelWithDict:(NSDictionary*)dict{
    
  
    [self setValuesForKeysWithDictionary:dict];
 
    return self;
}
-(NSDictionary *)modelToDictWithArray:(NSArray*)array{
    
    
   return  [self dictionaryWithValuesForKeys:array];
}
@end
