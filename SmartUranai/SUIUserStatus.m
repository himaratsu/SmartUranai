//
//  SUIUserStatus.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIUserStatus.h"

@implementation SUIUserStatus

- (id)initWithAst:(NSString *)userAst {
    if (self = [super init]) {
        _userAst = userAst;
    }
    
    return self;
}

+ (id)sampleStatus {
    // dummy
    return [[SUIUserStatus alloc] initWithAst:@"牡羊座"];
}

@end
