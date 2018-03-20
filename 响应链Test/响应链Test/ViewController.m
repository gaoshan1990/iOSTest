//
//  ViewController.m
//  响应链Test
//
//  Created by most on 2018/3/14.
//  Copyright © 2018年 most. All rights reserved.
//

#import "ViewController.h"
#import "TestButton.h"
@interface ViewController ()
@property(nonatomic,strong)TestButton *moveBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor  =[UIColor whiteColor];
    self.moveBtn =[[TestButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    [self.moveBtn setTitle:@"move" forState:UIControlStateNormal];
    self.moveBtn.backgroundColor  =[UIColor yellowColor];
//    self.moveBtn.enabled  = NO;
    [self.moveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.moveBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.moveBtn];
}

- (void)btnClick:(TestButton*)testBtn{
    
    testBtn.backgroundColor  =[UIColor redColor];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIResponder  *next =  [self nextResponder];
    
    NSMutableString * prefix = @"".mutableCopy;
    
    while (next != nil) {
        NSLog(@"%@%@", prefix, [next class]);
        [prefix appendString: @"--"];
        next = [next nextResponder];
    }
/*
 
 UIResponder * next = [self nextResponder];
 NSMutableString * prefix = @"".mutableCopy;
 
 while (next != nil) {
 NSLog(@"%@%@", prefix, [next class]);
 [prefix appendString: @"--"];
 next = [next nextResponder];
 }
 */
    
    
    NSLog(@"=====begin%@",event);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"=====move%@",event);
   
    UITouch  * touch  =  [touches anyObject];
    
    CGPoint currentPoint  =  [touch locationInView:self.moveBtn];
    
    
    CGPoint prePoint  =[touch previousLocationInView:self.moveBtn];
    
    CGFloat  offsetX =currentPoint.x  -prePoint.x;
    CGFloat  offsetY =currentPoint.y -prePoint.y;
    
    self.moveBtn.transform =CGAffineTransformTranslate(self.moveBtn.transform,offsetX, offsetY);
    
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"=====end%@",event);

}
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"=====cancell%@",event);

    
}
@end
