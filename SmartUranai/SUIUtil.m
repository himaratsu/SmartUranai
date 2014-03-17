//
//  SUIUtil.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIUtil.h"

@implementation SUIUtil

+ (NSArray *)signList {
    return @[@"牡羊座", @"牡牛座", @"双子座", @"蟹座", @"獅子座", @"乙女座", @"天秤座",
             @"蠍座", @"射手座", @"山羊座", @"水瓶座", @"魚座"];
}

+ (NSInteger)indexOfSign:(NSString *)sign {
    return [[self signList] indexOfObject:sign];
}


+ (NSArray *)notifSettingList {
    return @[@"1位の時のみ受け取る", @"順位に関係なく受け取る", @"受け取らない"];
}

+ (NSInteger)indexOfNotifSetting:(NSString *)notifSetting {
    return [[self notifSettingList] indexOfObject:notifSetting];
}

@end
