//
//  YLSCertifH5Controller.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/22.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSCertifH5Controller.h"
#import <WebKit/WebKit.h>
@interface YLSCertifH5Controller ()<WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate>
//网页加载进度视图
@property (nonatomic, strong) UIProgressView * progressView;

@end

@implementation YLSCertifH5Controller

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.Navtitle;
    self.view.backgroundColor = MainbackgroundColor;
    [self createUI];
    /**
     *  导航栏
     */
    [self setupNav];
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NavView];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, ScreenW-20, 44)];
    navLabel.text =  self.Navtitle;
    navLabel.textAlignment = 1;
    navLabel.textColor = [UIColor blackColor];
    [NavView addSubview:navLabel];
    
    //按钮
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(10, STATUS_BAR_HEIGHT, 44, 44);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    [thirdBtn1 addTarget:self action:@selector(LethAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn1];
    
}
-(void)LethAction{
    //    [self.navigationController popViewControllerAnimated:YES];
    
//    YLSCertificationController *homeVC = [[YLSCertificationController alloc] init];
//    UIViewController *target = nil;
//    for (UIViewController * controller in self.navigationController.viewControllers) {
//        if ([controller isKindOfClass:[homeVC class]]) {
//            target = controller;
//
//        }
//    }
//    if (target){
//        [self.navigationController popToViewController:target animated:YES];
//    }
    
    
    if (self.navigationController.viewControllers.count >= 2) {
        UIViewController *vc = [self.navigationController.viewControllers objectOrNilAtIndex:1];
        [self.navigationController popToViewController:vc animated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CertifiList" object:nil];

}
#pragma mark - UI
-(void)createUI{
    WKWebView *webview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    webview.navigationDelegate = self;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.agreeUrl]];
    [webview loadRequest:request];
    [self.view addSubview:webview];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
}
#pragma mark -- WKNavigationDelegate
/*
 WKNavigationDelegate主要处理一些跳转、加载处理操作，WKUIDelegate主要处理JS脚本，确认框，警告框等
 */
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [MBProgressHUD MBProgress:@"数据加载中..."];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    [MBProgressHUD hideHUD];
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    //    [self getCookie];
    [MBProgressHUD hideHUD];
    
    
}

//提交发生错误时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
    [MBProgressHUD hideHUD];
    
}

- (UIProgressView *)progressView
{
    if (!_progressView){
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0 + 1, self.view.frame.size.width, 2)];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor clearColor];
    }
    return _progressView;
}


@end
