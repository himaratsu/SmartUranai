//
//  SUIViewController.m
//  SmartUranai
//
//  Created by himara2 on 2014/03/16.
//  Copyright (c) 2014年 himara2. All rights reserved.
//

#import "SUIViewController.h"
#import <Social/Social.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "SUIUserStatus.h"
#import "SUIUserHoro.h"
#import "SUIPickerView.h"

#import "SUITitleCell.h"
#import "SUIContentCell.h"
#import "SUILoveCell.h"
#import "SUIJobCell.h"
#import "SUIMoneyCell.h"

#import "SUIUtil.h"

#import "SUISettingViewController.h"

@interface SUIViewController ()
<UITableViewDataSource, UITableViewDelegate,
UIActionSheetDelegate, UIAlertViewDelegate,
SUIPickerViewDelegate, SUIContentCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *controlView;

@property (nonatomic) SUIUserHoro *myHoro;
@property (nonatomic) SUIUserStatus *myStatus;
@property (nonatomic) SUIPickerView *pickerView;

@property (nonatomic) NSString *currentDateStr;
@property (nonatomic) NSString *currentSignStr;

@property (nonatomic) NSString *selectionString;

@property (nonatomic) SUIContentCell *currentContentCell;

@end


@implementation SUIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初期の場合はチュートリアルを表示
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isTutorialDone = [defaults boolForKey:@"TUTORIAL_DONE"];
    if (!isTutorialDone) {
        // チュートリアルを表示
        [self showHelloWorld];
    }

    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.contentInset = (UIEdgeInsets){
        .top = 0,
        .bottom = 88,
        .left = 0,
        .right = 0
    };
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // コンテンツを更新
    [self reload];
}


- (void)showHelloWorld {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ようこそSmartUranaiへ！"
                                                    message:@"ダウンロードありがとうございます。\nまず最初にあなたの星座を設定しましょう！"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"設定する", nil];
    [alert show];
}

#pragma mark - FetchContent

- (void)reloadContentWithCompletion:(void (^)(UIBackgroundFetchResult))completion {
    if ([self reload]) {
        // 更新された
        completion(UIBackgroundFetchResultNewData);
    }
    else {
        // 更新されなかった
        completion(UIBackgroundFetchResultNoData);
        return;
    }
    
    // 通知
    self.myStatus = [SUIUserStatus sharedInstance];
    if (_myHoro && [_myStatus isFireNotification:_myHoro.rank]) {
        [self fireNotification];
    }
}

// 本日の日付を返す
- (NSString *)todayStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd";
    
    NSDate *date = [NSDate date];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    
    return formattedDateString;
}

- (BOOL)shouldReload:(NSString *)todayStr {
    if ([_currentDateStr isEqualToString:todayStr]
        && [_currentSignStr isEqualToString:_myStatus.userAst]) {
        return NO;
    }
    return YES;
}

- (BOOL)reload {
    NSString *todayStr = [self todayStr];

    // ユーザーの星座情報を取得
    self.myStatus = [SUIUserStatus sharedInstance];
    
    if (![self shouldReload:todayStr]) {
        return NO;
    }

    // リクエストURLを生成
    NSString *requestUrl = [NSString stringWithFormat:@"http://api.jugemkey.jp/api/horoscope/free/%@", todayStr];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:requestUrl parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSArray *horoList = responseObject[@"horoscope"][todayStr];
             [horoList enumerateObjectsUsingBlock:^(NSDictionary *horo, NSUInteger idx, BOOL *stop) {
                 // 一致するか
                 if ([horo[@"sign"] isEqualToString:_myStatus.userAst]) {
                     // title
                     self.myHoro = [[SUIUserHoro alloc] initWithHoroDictionary:horo];
                     _myHoro.date = todayStr;
                     NSLog(@"userHoro[%@]", _myHoro);
                 }
             }];
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [_tableView reloadData];
             });
             
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self reloadTodayImage];
    
    return YES;
}

// 本日の画像を1枚選定
- (void)reloadTodayImage {
    srand((unsigned)time(NULL));
    NSInteger index = rand() % 53 + 1;
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%02d.jpg", index]];
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
        cell.dateLabel.text = _myHoro.date;
        cell.signLabel.text = _myHoro.sign;
        cell.rankLabel.text = [NSString stringWithFormat:@"%d", _myHoro.rank];
        
        _currentDateStr = _myHoro.date;
        _currentSignStr = _myHoro.sign;
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
        cell.delegate = self;
        
        self.currentContentCell = cell;
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}


- (void)fireNotification {

    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    
    // 日時を設定
    localNotif.fireDate = [[NSDate date] dateByAddingTimeInterval:5];
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
    // 通知メッセージ
    localNotif.alertBody = [NSString stringWithFormat:@"占いが更新されました！本日の[%@]の順位は[%d位]です！",
                            _myHoro.sign, _myHoro.rank];
    
    // 効果音は標準の効果音を利用する
    [localNotif setSoundName:UILocalNotificationDefaultSoundName];
    
    // 通知アラートのボタン表示名を指定
    localNotif.alertAction = @"Open";
    
    // 作成した通知イベントをアプリケーションに登録
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}


// 領域を指定して画像を切り抜く
-(UIImage *)captureImage
{
    // 描画領域の設定
    // FIXME: 15 is magic number for cut under gray space.
    CGSize size = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height - 15);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // SSに不要な部分は隠す, スクロールを一時的に無効化する
    _controlView.hidden = YES;
    CGPoint offset = _tableView.contentOffset;
    _tableView.contentOffset = CGPointMake(0, 0);
    
    // 文字選択を解除する
    if (_currentContentCell) {
        [_currentContentCell resetStringSelection];
    }
    
    // グラフィックスコンテキスト取得
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // コンテキストの位置を切り取り開始位置に合わせる
    CGPoint point = self.view.frame.origin;
    CGAffineTransform affineMoveLeftTop
    = CGAffineTransformMakeTranslation(
                                       -(int)point.x ,
                                       -(int)point.y );
    CGContextConcatCTM(context , affineMoveLeftTop );
    
    // viewから切り取る
    [(CALayer*)self.view.layer renderInContext:context];
    
    // 切り取った内容をUIImageとして取得
    UIImage *cnvImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // コンテキストの破棄
    UIGraphicsEndImageContext();
    
    // 隠していた部分を戻す
    _controlView.hidden = NO;
    _tableView.contentOffset = offset;
    
    return cnvImg;
}

#pragma mark - IBAction

- (IBAction)shareBtnTouched:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:@"Twitterへ投稿する", @"Facebookへ投稿する", @"LINEへ投稿する", nil];
    [sheet showInView:self.view];
    
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self showSignPicker];
}

- (void)showSignPicker {
    self.pickerView = [SUIPickerView loadFromIdiomNib];
    _pickerView.myDelegate = self;
    _pickerView.alpha = 0;
    _pickerView.type = PICKER_TYPE_SIGN;
    _pickerView.cancelBtn.hidden = YES;
    
    [self.view addSubview:_pickerView];
    
    [UIView animateWithDuration:0.2f animations:^{
        _pickerView.alpha = 1.0;
    }];
}


#pragma mark - SUIPickerViewDelegate

- (void)changeValueSubmit:(NSInteger)index type:(PICKER_TYPE)type {
    if (type == PICKER_TYPE_SIGN) {
        [_myStatus updateUserAst:index];
    }
    
    _pickerView.hidden = YES;
    
    // チュートリアル終了フラグを立てる
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"TUTORIAL_DONE"];
    [defaults synchronize];
    
    [self reload];
}


#pragma mark - SUIContentCellDelegate

- (void)didChangeSelectionString:(NSString *)str {
    // 選択文字列を記憶
    self.selectionString = str;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    else {
        UIImage *image = [self captureImage];
        switch (buttonIndex) {
            case 0:
                // Twitterへ
                [self postToTwitter:image];
                break;
            case 1:
                // Facebookへ
                [self postToFacebook:image];
                break;
            case 2:
                // LINEへ
                [self postToLine:image];
                break;
        }
    }
}

- (NSString *)stringByHoro {
    if (_selectionString && ![_selectionString isEqualToString:@""]) {
        return [NSString stringWithFormat:@"\"%@\" 今日の%@の運勢は%d位です / Download->",
                _selectionString, _myHoro.sign, _myHoro.rank];
    }
    else {
        return [NSString stringWithFormat:@"今日の%@の運勢は%d位です / Download->", _myHoro.sign, _myHoro.rank];
    }
//    return [NSString stringWithFormat:@"今日の%@の運勢は%d位です", _myHoro.sign, _myHoro.rank];
}

// Twitterに投稿
- (void)postToTwitter:(UIImage *)image {
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
    [vc setInitialText:[self stringByHoro]];
    [vc addImage:image];
    [vc addURL:[NSURL URLWithString:APP_STORE_URL]];
    [self presentViewController:vc animated:YES completion:^{
        self.selectionString = @"";
    }];
}

// Facebookに投稿
- (void)postToFacebook:(UIImage *)image {
    SLComposeViewController *vc = [SLComposeViewController
                                   composeViewControllerForServiceType:SLServiceTypeFacebook];
    [vc setInitialText:[self stringByHoro]];
    [vc addImage:image];
    [vc addURL:[NSURL URLWithString:APP_STORE_URL]];
    [self presentViewController:vc animated:YES completion:^{
        self.selectionString = @"";
    }];
}

// LINEに投稿
- (void)postToLine:(UIImage *)image {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setData:UIImagePNGRepresentation(image) forPasteboardType:@"public.png"];
    
    // pasteboardを使ってパスを生成
    NSString *LineUrlString = [NSString stringWithFormat:@"line://msg/image/%@",
                               　　　　　　　　　　　　　　　pasteboard.name];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LineUrlString]];

}

#pragma mark - Status Bar

// ステータスバーの非表示
- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Storyboard

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Setting"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        SUISettingViewController *settingVC = (SUISettingViewController *)nav.viewControllers[0];
        settingVC.myStatus = _myStatus;
    }
}

@end
