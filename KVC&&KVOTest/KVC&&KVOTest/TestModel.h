//
//  TestModel.h
//  KVC&&KVOTest
//
//  Created by most on 2018/3/20.
//  Copyright © 2018年 most. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestModel : NSObject
@property(nonatomic,strong) NSString * title;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * leve;
@property(nonatomic,strong) NSString * icon;
@property(nonatomic,strong) NSString * img;
-(instancetype)testModelWithDict:(NSDictionary*)dict;
-(NSDictionary *)modelToDictWithArray:(NSArray*)array;
@end
