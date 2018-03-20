//
//  NotificationService.m
//  APNsUI
//
//  Created by most on 2018/2/28.
//  Copyright © 2018年 most. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    //重写属性
    
    self.bestAttemptContent.title = @"这个是修改过的title" ;
    self.bestAttemptContent.body =@"这个是修改过的body";
    self.bestAttemptContent.badge = @20;
    self.bestAttemptContent.subtitle =@"这是修改过的子标题";
    /*
     
     {
     "aps" : {
     "alert" : "Your message here.",
     "badge" : 11,
     "sound" : "default",
     "category" : "Category1",
     "imageUrl" :  "https://img1.gtimg.com/sports/pics/hv1/194/44/2136/138904814.jpg"
     "mutable-content" : 1 // 这是属性必须这样写，代表推送的内容可以修改的
     },
     }
     */
    // 可以在这里添加附件，有30s如果超时，则执行serviceExtensionTimeWillExpire，推送原来的内容
    
    NSDictionary * userInfo = request.content.userInfo;
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    //服务端与客户端约定各种资源的url，根据url资源进行下载
    NSDictionary * apsDict = [userInfo objectForKey:@"aps"];
    
    NSString *imageUrl =apsDict[@"imageUrl"];
    NSString * typeString ;
    NSURL * url;
    if (imageUrl.length>0) {
        url = [NSURL URLWithString:imageUrl];
        typeString = @"jpg";
    }
    if (url) {
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:urlRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSString *path = [location.path stringByAppendingString:[NSString stringWithFormat:@".%@",typeString]];
                NSError *err = nil;
                NSURL * pathUrl = [NSURL fileURLWithPath:path];
                
                [[NSFileManager defaultManager] moveItemAtURL:location toURL:pathUrl error:nil];
                UNNotificationAttachment *resource_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:pathUrl options:nil error:&err];
                if (resource_attachment) {
                    self.bestAttemptContent.attachments = @[resource_attachment];
                }
                if (error) {
                    NSLog(@"%@", error);
                }
                //设置为@""以后，进入app将没有启动页
                self.bestAttemptContent.launchImageName = @"";
                UNNotificationSound *sound = [UNNotificationSound defaultSound];
                self.bestAttemptContent.sound = sound;
                self.contentHandler(self.bestAttemptContent);
            }
            else{
                self.contentHandler(self.bestAttemptContent);
            }
        }];
        [task resume];
    }
    else{
        self.contentHandler(self.bestAttemptContent);
    }
    
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
