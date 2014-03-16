//
//  SUIViewController.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIViewController.h"
#import <AFNetworking/AFNetworking.h>

#import "SUIUserStatus.h"
#import "SUIUserHoro.h"

#import "SUITitleCell.h"
#import "SUIContentCell.h"
#import "SUILoveCell.h"
#import "SUIJobCell.h"
#import "SUIMoneyCell.h"


@interface SUIViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) SUIUserHoro *myHoro;


@end


@implementation SUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = (UIEdgeInsets){
        .top = 0,
        .bottom = 88,
        .left = 0,
        .right = 0
    };
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // コンテンツを更新
//    [self reload];
}


#pragma mark - FetchContent

- (void)reloadContentWithCompletion:(void (^)(UIBackgroundFetchResult))completion {
    [self reload];
    
    // TODO: 分岐
    completion(UIBackgroundFetchResultNewData);
}

- (void)reload {
    // ユーザーの星座情報を取得
    // TODO: ちゃんと作る
    SUIUserStatus *status = [SUIUserStatus sampleStatus];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://api.jugemkey.jp/api/horoscope/free" parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *horoList = responseObject[@"horoscope"][@"2014/03/01"];
             [horoList enumerateObjectsUsingBlock:^(NSDictionary *horo, NSUInteger idx, BOOL *stop) {
                 // 一致するか
                 if ([horo[@"sign"] isEqualToString:status.userAst]) {
                     // title
                     self.myHoro = [[SUIUserHoro alloc] initWithHoroDictionary:horo];
                     NSLog(@"userHoro[%@]", _myHoro);
                 }
             }];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [_tableView reloadData];
             });
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        return 3;
    }
    else if (section == 2) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    
    if (indexPath.section == 0) {
        cellIdentifier = @"TitleCell";
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cellIdentifier = @"MoneyStarCell";
                break;
            case 1:
                cellIdentifier = @"JobStarCell";
                break;
            case 2:
                cellIdentifier = @"LoveStarCell";
                break;
        }
    }
    else if (indexPath.section == 2) {
        cellIdentifier = @"ContentCell";
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell.frame.size.height;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    
    if (indexPath.section == 0) {
        cellIdentifier = @"TitleCell";
        SUITitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.dateLabel.text = @"03/01";
        cell.signLabel.text = _myHoro.sign;
        cell.rankLabel.text = [NSString stringWithFormat:@"%d", _myHoro.rank];
        return cell;
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                cellIdentifier = @"LoveStarCell";
                SUILoveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                cell.starNum = _myHoro.love;
                return cell;
            }
            case 1:
            {
                cellIdentifier = @"JobStarCell";
                SUIJobCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                cell.starNum = _myHoro.job;
                return cell;
            }
            case 2:
            {
                cellIdentifier = @"MoneyStarCell";
                SUIMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                cell.starNum = _myHoro.money;
                return cell;
            }
        }
    }
    else if (indexPath.section == 2) {
        cellIdentifier = @"ContentCell";
        SUIContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.content = _myHoro.content;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}


#pragma mark - Status Bar

// ステータスバーの非表示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
