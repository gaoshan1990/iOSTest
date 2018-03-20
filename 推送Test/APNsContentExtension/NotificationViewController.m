//
//  NotificationViewController.m
//  APNsContentExtension
//
//  Created by most on 2018/2/28.
//  Copyright © 2018年 most. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}


- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion;{
    if ([response isKindOfClass:[UNTextInputNotificationAction class]]) {
        //处理提交文本的逻辑
    }
    if ([response.actionIdentifier isEqualToString:@"action1"]) {
        //处理按钮3
    }
    if ([response.actionIdentifier isEqualToString:@"action2"]) {
        //处理按钮2
    }
    //可根据action的逻辑回调的时候传入不同的UNNotificationContentExtensionResponseOption
    completion(UNNotificationContentExtensionResponseOptionDismiss);
}
- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    
    
    UNNotificationAttachment * attachment = notification.request.content.attachments.firstObject;
    if (attachment) {
        //开始访问pushStore的存储权限
        [attachment.URL startAccessingSecurityScopedResource];
        NSData * data = [NSData dataWithContentsOfFile:attachment.URL.path];
        [attachment.URL stopAccessingSecurityScopedResource];
//        self.imageview.image = [UIImage imageWithData:data];
    }
}

@end
