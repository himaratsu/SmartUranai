//
//  SUIContentCell.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIContentCell.h"

@interface SUIContentCell () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation SUIContentCell

- (void)awakeFromNib {
    _contentTextView.delegate = self;
}

- (void)setContent:(NSString *)content {
    if (content == nil) {
        content = @"";
    }
    
    UIFont *font = [UIFont systemFontOfSize:20.0f];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setLineSpacing:4];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName: [UIColor whiteColor] };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    [_contentTextView setAttributedText: attributedString];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    UITextRange *selectedRange = [textView selectedTextRange];
    NSString *selectedText = [textView textInRange:selectedRange];
    
    if ([_delegate respondsToSelector:@selector(didChangeSelectionString:)]) {
        [_delegate didChangeSelectionString:selectedText];
    }
}

- (void)resetStringSelection {
    _contentTextView.selectedTextRange = nil;
}

@end
