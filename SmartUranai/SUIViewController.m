//
//  SUIViewController.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIViewController.h"

@interface SUIViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
}


#pragma mark - FetchContent

- (void)reload {
    
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
    return cell;
}


#pragma mark - Status Bar

// ステータスバーの非表示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
