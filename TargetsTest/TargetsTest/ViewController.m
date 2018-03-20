//
//  ViewController.m
//  TargetsTest
//
//  Created by most on 2018/1/23.
//  Copyright © 2018年 most. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UILabel *targetlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200,self.view.bounds.size.width, 100)];
    [self.view addSubview:targetlabel];

        #if TargetTest2_Debug

            targetlabel.text =@"这个是TargetsTest2_Debug";
            targetlabel.backgroundColor =[UIColor yellowColor];
    
        #elif TargetTest2_Release
    
            targetlabel.text =@"这个是TargetsTest2_Release";
    
            targetlabel.backgroundColor =[UIColor redColor];
        #elif TargetTest1_Debug
            //...
            targetlabel.text =@"这个是TargetsTest1_Debug";
            targetlabel.backgroundColor =[UIColor blueColor];
    
        #elif TargetTest1_Release
    
            targetlabel.text =@"这个是TargetsTest1_Release";
    
            targetlabel.backgroundColor =[UIColor greenColor];
        #endif
    
    
    
}




@end
