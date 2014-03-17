//
//  SUIUtil.h
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUIUtil : NSObject

+ (NSArray *)signList;
+ (NSInteger)indexOfSign:(NSString *)sign;

+ (NSArray *)notifSettingList;
+ (NSInteger)indexOfNotifSetting:(NSString *)notifSetting;

@end
