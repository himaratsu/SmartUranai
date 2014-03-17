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

- (void)loadUserStatus {
    self.userAst = [[NSUserDefaults standardUserDefaults] objectForKey:@"USER_AST"];
    if (_userAst == nil) {
        self.userAst = @"牡羊座";
    }
    
    self.notifSetting = [[NSUserDefaults standardUserDefaults] objectForKey:@"NOTIF_SETTING"];
    if (_notifSetting == nil) {
        self.notifSetting = @"1位の時のみ受け取る";
    }
}

- (NSString *)updateUserAst:(NSInteger)index {
    _userAst = [SUIUtil signList][index];
    
    // 保存処理
    [[NSUserDefaults standardUserDefaults] setObject:_userAst forKey:@"USER_AST"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return _userAst;
}

- (NSString *)updateNotifSetting:(NSInteger)index {
    _notifSetting = [SUIUtil notifSettingList][index];
    
    // 保存処理
    [[NSUserDefaults standardUserDefaults] setObject:_notifSetting forKey:@"NOTIF_SETTING"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return _notifSetting;
}

@end
