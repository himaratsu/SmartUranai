//
//  SUIUserHoro.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIUserHoro.h"

@implementation SUIUserHoro

- (id)initWithSign:(NSString *)sign
              rank:(NSInteger)rank
             total:(NSInteger)total
              love:(NSInteger)love
               job:(NSInteger)job
             money:(NSInteger)money
           content:(NSString *)content
{
    if (self = [super init]) {
        _sign = sign;
        _rank = rank;
        _total = total;
        _love = love;
        _job = job;
        _money = money;
        _content = content;
    }
    return self;
}


- (id)initWithHoroDictionary:(NSDictionary *)dictionary {
    self = [self initWithSign:dictionary[@"sign"]
                         rank:[dictionary[@"rank"] integerValue]
                        total:[dictionary[@"total"] integerValue]
                         love:[dictionary[@"love"] integerValue]
                          job:[dictionary[@"job"] integerValue]
                        money:[dictionary[@"money"] integerValue]
                      content:dictionary[@"content"]];
    return self;
}

@end
