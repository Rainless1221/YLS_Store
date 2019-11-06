//
//  FBHgoodDetailsController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "FBHgoodDetailsController.h"

@interface FBHgoodDetailsController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIImageView * detaImage;
@property (strong,nonatomic)UIScrollView * DetaScrollView;
@property (strong,nonatomic)goodDetailsView * DetaView;
@property (strong,nonatomic)UIView * NavView;

/** 滚动高度 */
@property (nonatomic) CGFloat halfHeight;
@end

@implementation FBHgoodDetailsController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _halfHeight = (CGRectGetHeight([UIScreen mainScreen].bounds)) * 0.5 - 64;
    [self createUI];

    [self setupNav];
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.detaImage];
    [self.view addSubview:self.DetaScrollView];
    [self.DetaScrollView addSubview:self.DetaView];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    [self.view addSubview:NavView];
    //背景图片
    UIImageView *NavImg = [[UIImageView alloc]initWithFrame:NavView.frame];
    //    NavImg.image = [UIImage imageNamed:@"bg_index_top_scene"];
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    layer.colors=@[(__bridge id)UIColorFromRGB(0x4EC3FF).CGColor,(__bridge id)UIColorFromRGB(0x45A6FF).CGColor,(__bridge id)UIColorFromRGB(0x3D8AFF).CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.frame = NavImg.bounds;
    [NavImg.layer addSublayer:layer];
    
//    self.NavImg = NavImg;
//    [NavView addSubview:NavImg];
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, STATUS_BAR_HEIGHT, 220, 44)];
    navLabel.text = @"";
    navLabel.textColor = [UIColor whiteColor];
    [NavView addSubview:navLabel];
//    self.navLabel = navLabel;
    //返回
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 40, 44);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_white_normal"] forState:UIControlStateNormal];
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_white_normal"] forState:UIControlStateSelected];
    [thirdBtn1 addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn1];
    
    //
    UIButton *thirdBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn2.frame = CGRectMake(ScreenW-9-40, STATUS_BAR_HEIGHT, 40, 44);
    [thirdBtn2 setImage:[UIImage imageNamed:@"icn_nav_set_normal"] forState:UIControlStateNormal];
    [thirdBtn2 setImage:[UIImage imageNamed:@"i·cn_nav_set_more_reddot_normal"] forState:UIControlStateSelected];
    [NavView addSubview:thirdBtn2];
//    [thirdBtn2 addTarget:self action:@selector(SetupAction) forControlEvents:UIControlEventTouchUpInside];
    
    //    thirdBtn1.selected = YES;
    //    thirdBtn2.selected = YES;
    
    self.NavView = NavView;
    
}
-(void)popAction{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - ScrollViewDelegate
// 滑动时要执行的代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (_halfHeight + 64 + offsetY)/_halfHeight);
    if (offsetY >= - _halfHeight - 64) {
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        self.NavView.backgroundColor = UIColorFromRGBA(0x999999, offsetY);
//        self.NavImg.alpha = offsetY;
    } else {
        //替换这种方式
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        self.NavView.backgroundColor = UIColorFromRGBA(0x999999, 1);
//        self.NavImg.alpha = 1;
    }
}
#pragma mark - 懒加载
-(UIScrollView *)DetaScrollView{
    if (!_DetaScrollView) {
        _DetaScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _DetaScrollView.backgroundColor = [UIColor clearColor];
        _DetaScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 935);
        _DetaScrollView.delegate = self;
//        _DetaScrollView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(ViewheaderRereshing)];
    }
    return _DetaScrollView;
}
-(goodDetailsView *)DetaView{
    if (!_DetaView) {
        _DetaView =[[goodDetailsView alloc]initWithFrame:CGRectMake(0, 320, ScreenW, ScreenH-20)];
        _DetaView.backgroundColor = [UIColor clearColor];
        _DetaView.layer.cornerRadius = 5;
//        _DetaView.delagate = self;
        
    }
    return _DetaView;
}
-(UIImageView *)detaImage{
    if (!_detaImage) {
        _detaImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 345)];
        _detaImage.image = [UIImage imageNamed:@"jiameng_top_bg"];
    }
    return _detaImage;
}
@end
