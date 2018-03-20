//
//  TestButton.m
//  响应链Test
//
//  Created by most on 2018/3/14.
//  Copyright © 2018年 most. All rights reserved.
//

#import "TestButton.h"

@implementation TestButton

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    return [super hitTest:point withEvent:event];
    
    
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    CGRect  rect  =CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
    
    
     BOOL  status =    CGRectContainsPoint(rect, point);
    

    return  status;
    
}
@end
