//
//  QARSimpleWebViewController.m
//  QiitaAdventReader
//
//  Created by rhiramat on 2013/12/05.
//  Copyright (c) 2013年 Ryosuke Hiramatsu. All rights reserved.
//

#import "QARSimpleWebViewController.h"

@interface QARSimpleWebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation QARSimpleWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = [[NSBundle mainBundle] pathForResource:_loadFilePath ofType:nil];
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
//    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://yahoo.co.jp"]];
    [_webView loadRequest:req];
    
    [self.navigationController setNavigationBarHidden:NO];
}


@end
