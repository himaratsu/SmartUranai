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
    [_webView loadRequest:req];
    
    self.view.backgroundColor = _webView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    
    [self.navigationController setNavigationBarHidden:NO];
}


@end
