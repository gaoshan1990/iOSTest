//
//  AppDelegate.m
//  推送
//
//  Created by most on 2018/2/28.
//  Copyright © 2018年 most. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "TestViewController.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [self registAPNsWithApplication:application];
    
    return YES;
}


- (void)registAPNsWithApplication:(UIApplication*)application{
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=10.0) {
        
        UNUserNotificationCenter  *center =[UNUserNotificationCenter currentNotificationCenter];
        
        [center setNotificationCategories:[self createNotificationCategory]];
        
        center.delegate =self;
        //注册推送
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus==UNAuthorizationStatusNotDetermined) {
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        [[UIApplication sharedApplication] registerForRemoteNotifications];
                    } else {
                        
                    }
                }];
            }
            else{
                //do other things
            }
        }];
        
    }
    
    
}
- (NSSet *)createNotificationCategory{
    
    UNNotificationAction  *action1 =[UNNotificationAction actionWithIdentifier:@"action1" title:@"按钮1" options:UNNotificationActionOptionForeground|UNNotificationActionOptionDestructive|UNNotificationActionOptionAuthenticationRequired];
    
    UNNotificationAction *action2 =[UNNotificationAction actionWithIdentifier:@"action2" title:@"按钮2" options:UNNotificationActionOptionForeground|UNNotificationActionOptionDestructive|UNNotificationActionOptionAuthenticationRequired];
    
    UNNotificationCategory *category1 =[UNNotificationCategory categoryWithIdentifier:@"category1" actions:@[action1,action2] intentIdentifiers:@[@"action1",@"action2"] options:UNNotificationCategoryOptionNone];
    
    
    UNTextInputNotificationAction *text =[UNTextInputNotificationAction actionWithIdentifier:@"inPutText" title:@"textTitle" options:UNNotificationActionOptionForeground|UNNotificationActionOptionDestructive|UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"发送" textInputPlaceholder:@"这是一个占位"];
    
    UNNotificationCategory *category2 =[UNNotificationCategory categoryWithIdentifier:@"category2" actions:@[text] intentIdentifiers:@[@"inPutText"] options:UNNotificationCategoryOptionNone];
    
    
    return  [NSSet setWithObjects:category1,category2, nil];
    
    
}
#pragma mark ---App前台接到推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    UNNotificationRequest *request = notification.request;
    // 收到推送的请求
    UNNotificationContent *content = request.content;
    // 收到推送的消息内容
    NSNumber *badge = content.badge;
    // 推送消息的角标
    NSString *body = content.body;
    // 推送消息体
    UNNotificationSound *sound = content.sound;
    // 推送消息的声音
    NSString *subtitle = content.subtitle;
    // 推送消息的副标题
    NSString *title = content.title;
    // 推送消息的标题
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 前台收到远程通知");
        
    } else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        
    }
    
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置 }
    
    
}
#pragma mark-- App 在后台/点击推送是后/点击按钮时候
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request;
    // 收到推送的请求
    UNNotificationContent *content = request.content;
    // 收到推送的消息内容
    NSNumber *badge = content.badge;
    // 推送消息的角标
    NSString *body = content.body;
    // 推送消息体
    UNNotificationSound *sound = content.sound;
    // 推送消息的声音
    NSString *subtitle = content.subtitle;
    // 推送消息的副标题
    NSString *title = content.title;
    // 推送消息的标题
    
    /*
     
     
     {
     "aps" : {
     "alert" : "Your message here.",
     "badge" : 11,
     "sound" : "default",
     "category" : "category1",
     },
     }
     
     */
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        if ([response isKindOfClass:[UNTextInputNotificationAction class]]) {
            
            UNTextInputNotificationResponse *textNotificationResponse = (UNTextInputNotificationResponse *)response;
            NSString *text =  textNotificationResponse.userText;
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"输入内容" message:text preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            return;
            
        }else{
            
            if ([response.actionIdentifier isEqualToString:@"action1"]) {
                
                TestViewController *testVc =[[TestViewController alloc] init];
                
                UINavigationController *navi  = (UINavigationController*)[UIApplication sharedApplication].delegate.window.rootViewController ;
                [navi pushViewController:testVc animated:YES];
                return;
            
            }
            if ([response.actionIdentifier isEqualToString:@"action2"]) {
                
                
                [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[response.notification.request.identifier]];
            }
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"文本框输入" message:response.notification.request.content.body preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            
        }
        
        NSLog(@"iOS10 收到远程通知%@",badge);
        
    } else {
        // 判断为本地通知
        
    }
    completionHandler();
}


@end
