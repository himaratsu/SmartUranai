//
//  SUIContentCell.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIContentCell.h"

@interface SUIContentCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation SUIContentCell

- (void)setContent:(NSString *)content {
    if (content == nil) {
        content = @"";
    }
    
    UIFont *font = [UIFont systemFontOfSize:17.0f];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setLineSpacing:4];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    [_contentLabel setAttributedText: attributedString];
}


@end
