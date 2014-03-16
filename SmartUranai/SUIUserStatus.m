//
//  SUIUserStatus.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIUserStatus.h"
#import "SUIUtil.h"

@implementation SUIUserStatus

- (id)initWithAst:(NSString *)userAst notifSetting:(NSString *)notifSetting {
    if (self = [super init]) {
        _userAst = userAst;
        _notifSetting = notifSetting;
    }
    
    return self;
}

+ (id)sampleStatus {
    // dummy
    return [[SUIUserStatus alloc] initWithAst:@"牡羊座" notifSetting:@"1位の時のみ受け取る"];
}

- (NSString *)updateUserAst:(NSInteger)index {
    _userAst = [SUIUtil signList][index];
    
    // TODO: 保存処理
    
    return _userAst;
}

- (NSString *)updateNotifSetting:(NSInteger)index {
    _notifSetting = [SUIUtil notifSettingList][index];
    
    // TODO: 保存処理
    
    return _notifSetting;
}

@end
