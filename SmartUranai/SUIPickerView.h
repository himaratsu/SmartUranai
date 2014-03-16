//
//  SUIPickerView.h
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PICKER_TYPE_SIGN,
    PICKER_TYPE_PUSH,
} PICKER_TYPE;


@protocol SUIPickerViewDelegate <NSObject>

- (void)changeValueSubmit:(NSInteger)index type:(PICKER_TYPE)type;
- (void)closeWithoutChange;

@end


@interface SUIPickerView : UIView

+ (id)loadFromIdiomNib;

@property (nonatomic) NSArray *dataList;
@property (nonatomic, assign) PICKER_TYPE type;

@property (nonatomic, weak) id<SUIPickerViewDelegate> myDelegate;

@end
