//
//  SUIPickerView.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIPickerView.h"
#import "SUIUtil.h"

@interface SUIPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *backLayerView;

@property (nonatomic) NSInteger selectedIndex;

@end

@implementation SUIPickerView

+ (id)loadFromIdiomNib
{
    NSString *nibName = NSStringFromClass([self class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    return [[nib instantiateWithOwner:nil options:nil] objectAtIndex:0];
}

- (void)awakeFromNib {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backLayerTouched)];
    [_backLayerView addGestureRecognizer:tapGesture];
}

#pragma mark - Getter & Setter

- (void)setType:(PICKER_TYPE)type {
    [_picker selectedRowInComponent:0];
    
    _type = type;
    
    switch (type) {
        case PICKER_TYPE_SIGN:
            self.dataList = [SUIUtil signList];
            self.titleLabel.text = @"星座を選んでください";
            break;
        case PICKER_TYPE_PUSH:
            self.dataList = [SUIUtil notifSettingList];
            self.titleLabel.text = @"通知設定を選んでください";
            break;
    }
    
    [_picker reloadAllComponents];
}

- (void)setInitialIndex:(NSInteger)initialIndex {
    _initialIndex = initialIndex;
    [_picker selectRow:_initialIndex inComponent:0 animated:NO];
    
    [_picker reloadAllComponents];
}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_dataList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return  _dataList[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedIndex = row;
}

#pragma mark - IBAction

- (IBAction)okBtnTouched:(id)sender {
    if ([_myDelegate respondsToSelector:@selector(changeValueSubmit:type:)]) {
        [_myDelegate changeValueSubmit:_selectedIndex type:_type];
    }
}

- (IBAction)cancelBtnTouched:(id)sender {
    if ([_myDelegate respondsToSelector:@selector(closeWithoutChange)]) {
        [_myDelegate closeWithoutChange];
    }
}

- (void)backLayerTouched {
    // キャンセルボタンが非表示の場合、backLayerタップによるキャンセルを禁止
    if (_cancelBtn.hidden == YES) {
        return;
    }
    
    if ([_myDelegate respondsToSelector:@selector(closeWithoutChange)]) {
        [_myDelegate closeWithoutChange];
    }
}

@end
