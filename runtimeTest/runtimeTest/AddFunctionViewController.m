//
//  AddFunctionViewController.m
//  runtimeTest
//
//  Created by most on 2018/3/16.
//  Copyright © 2018年 most. All rights reserved.
//

#import "AddFunctionViewController.h"
#import "PerSon.h"
@interface AddFunctionViewController ()

@end

@implementation AddFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    PerSon  *p =[[PerSon alloc] init];
    
    [p performSelector:@selector(run)];
}


@end
