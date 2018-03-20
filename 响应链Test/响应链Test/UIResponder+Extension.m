//
//  UIResponder+Extension.m
//  响应链Test
//
//  Created by most on 2018/3/14.
//  Copyright © 2018年 most. All rights reserved.
//

#import "UIResponder+Extension.h"

@implementation UIResponder (Extension)
-(void)routerEvent:(id)info{
    
    [self.nextResponder routerEvent:info];
}
@end
