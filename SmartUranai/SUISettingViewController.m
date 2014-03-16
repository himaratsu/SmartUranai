//
//  SUISettingViewController.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUISettingViewController.h"
#import "SUIPickerView.h"
#import "SUIUserStatus.h"

@interface SUISettingViewController ()
<UITableViewDataSource, UITableViewDelegate, SUIPickerViewDelegate>

@property (nonatomic) SUIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SUISettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 4;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                // 星座cell
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SignCell"];
                cell.detailTextLabel.text = _myStatus.userAst;
                return cell;
            }
            case 1:
            {
                // 通知cell
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotifCell"];
                cell.detailTextLabel.text = _myStatus.notifSetting;
                return cell;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                // 使い方cell
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HowToCell"];
                return cell;
            }
            case 1:
            {
                // レビューcell
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell"];
                return cell;
            }
            case 2:
            {
                // お問い合わせcell
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportCell"];
                return cell;
            }
            case 3:
            {
                // ソフトウェアガイドラインcell
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LicenseCell"];
                return cell;
            }
            default:
                break;
        }
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"設定";
        case 1:
            return @"アプリについて";
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                // あなたの星座
                [self showSignPicker];
                break;
            }
            case 1:
            {
                // 通知
                [self showNotifPicker];
                break;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                // 使い方cell
                // TODO: 処理（アプリ内ブラウザ）
                break;
            }
            case 1:
            {
                // レビューcell
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_STORE_URL]];
                break;
            }
            case 2:
            {
                // お問い合わせcell
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SUPPORT_URL]];
                break;
            }
            case 3:
            {
                // ソフトウェアガイドラインcell
                // TODO: 処理（アプリ内ブラウザ）
                break;
            }
            default:
                break;
        }
    }
}


- (void)showSignPicker {
    if (_pickerView == nil) {
        self.pickerView = [SUIPickerView loadFromIdiomNib];
        _pickerView.myDelegate = self;
        [self.view addSubview:_pickerView];
    }
    else {
        _pickerView.hidden = NO;
    }
    _pickerView.type = PICKER_TYPE_SIGN;
}

- (void)showNotifPicker {
    if (_pickerView == nil) {
        self.pickerView = [SUIPickerView loadFromIdiomNib];
        _pickerView.myDelegate = self;
        [self.view addSubview:_pickerView];
    }
    else {
        _pickerView.hidden = NO;
    }
    _pickerView.type = PICKER_TYPE_PUSH;
}


#pragma mark - SUIPickerViewDelegate

- (void)changeValueSubmit:(NSInteger)index type:(PICKER_TYPE)type {
    if (type == PICKER_TYPE_SIGN) {
        [_myStatus updateUserAst:index];
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (type == PICKER_TYPE_PUSH) {
        [_myStatus updateNotifSetting:index];
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]]withRowAnimation:UITableViewRowAnimationNone];
    }
    
    _pickerView.hidden = YES;
}

- (void)closeWithoutChange {
    _pickerView.hidden = YES;
}


#pragma mark - IBAction

- (IBAction)backBtnTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Status Bar

// ステータスバーの非表示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}



@end
