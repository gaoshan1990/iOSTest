//
//  TestViewController.m
//  推送
//
//  Created by most on 2018/2/28.
//  Copyright © 2018年 most. All rights reserved.
//

#import "TestViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor =[UIColor redColor];
    
    [self initLocationNofication];

}

- (void)initLocationNofication{
    
    UNMutableNotificationContent *content =[[UNMutableNotificationContent alloc] init];
    
    content.title =@"本地推送的title";
    content.subtitle =@"本地推送的子title";
    content.body =@"本地推送的内容";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image1" ofType:@"png"];
    
    NSError *error = nil;

    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    content.attachments =@[attachment];
    
    content.launchImageName = @"";
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:3 repeats:NO];
    NSString *requestIdentifer = @"time interval request";
    content.categoryIdentifier = @"category1";
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    [self initLocationNofication];
}


@end
