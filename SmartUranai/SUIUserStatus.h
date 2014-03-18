//
//  SUIUserStatus.h
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUIUserStatus : NSObject

@property (nonatomic, strong) NSString* userAst;        // 登録星座
@property (nonatomic, strong) NSString* notifSetting;   // 通知設定

+ (id)sampleStatus;
- (id)initWithAst:(NSString *)userAst notifSetting:(NSString *)notifSetting;
- (void)loadUserStatus;
- (BOOL)isFireNotification:(NSInteger)sign;
- (NSString *)updateUserAst:(NSInteger)index;
- (NSString *)updateNotifSetting:(NSInteger)index;

@end
