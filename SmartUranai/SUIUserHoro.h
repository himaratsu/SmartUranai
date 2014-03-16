//
//  SUIUserHoro.h
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SUIUserHoro : NSObject

@property (nonatomic, strong) NSString *sign;
@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger love;
@property (nonatomic, assign) NSInteger job;
@property (nonatomic, assign) NSInteger money;

@property (nonatomic, strong) NSString *content;


- (id)initWithSign:(NSString *)sign
              rank:(NSInteger)rank
             total:(NSInteger)total
              love:(NSInteger)love
               job:(NSInteger)job
             money:(NSInteger)money
           content:(NSString *)content;

- (id)initWithHoroDictionary:(NSDictionary *)dictionary;

@end
