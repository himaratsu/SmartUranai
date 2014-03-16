//
//  SUIAppDelegate.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIAppDelegate.h"
#import "SUIViewController.h"

#import <Parse/Parse.h>

@implementation SUIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    // regist push notification
    [Parse setApplicationId:@"0BpCjAW5zJlc3qLYfgacIOHiohEkGhoGZ3ybYicX"
                  clientKey:@"QBxZ0e8tPm12fvL298cz6yUgy6nJGOKvi1ajxBWu"];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    return YES;
}

// push登録
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation saveInBackground];
}

// Silent Push Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"silent push!");
    
    
    // ---------------------------------------------
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    // 日時を設定
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:5];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // 通知メッセージ
    localNotif.alertBody = [NSString stringWithFormat:@"silent push受け取り!"];
    
    // 効果音は標準の効果音を利用する
    [localNotif setSoundName:UILocalNotificationDefaultSoundName];
    
    // 通知アラートのボタン表示名を指定
    localNotif.alertAction = @"Open";
    
    // 作成した通知イベントをアプリケーションに登録
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    // ---------------------------------------------
    
    
    SUIViewController *vc = ((UINavigationController *)self.window.rootViewController).viewControllers[0];
    [vc reloadContentWithCompletion:completionHandler];
}

@end
