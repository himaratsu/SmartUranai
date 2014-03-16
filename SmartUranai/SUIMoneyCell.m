//
//  SUIMoneyCell.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIMoneyCell.h"

@interface SUIMoneyCell ()

@property (weak, nonatomic) IBOutlet UILabel *starLabel;

@end


@implementation SUIMoneyCell

- (void)setStarNum:(NSInteger)starNum {
    _starNum = starNum;
    
    NSMutableString *labelText = [NSMutableString string];
    for (int i=0; i<_starNum; i++) {
        [labelText appendString:@"★"];
    }
    
    _starLabel.text = labelText;
}

@end
