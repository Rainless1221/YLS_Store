//
//  BaseNavigationController.m
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/2/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationControllerAppearance];
  
  

}
- (void)popToBack
{
    [self popViewControllerAnimated:YES];
}
#pragma mark - private methods
- (void)setupNavigationControllerAppearance
{
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
//        [navigationBarAppearance setBackgroundImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forBarMetrics:UIBarMetricsDefault];
    //    [navigationBarAppearance setBackgroundImage:[self getImageWithColor:MainColor] forBarMetrics:UIBarMetricsDefault];
    navigationBarAppearance.translucent = NO;
    
    //移除导航栏下发的线
    [navigationBarAppearance setShadowImage:[[UIImage alloc] init]];
    //    [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    
    // 导航栏标题字体大小及颜色
    NSDictionary *textAttributes = @{NSFontAttributeName:NavTitleFont,NSForegroundColorAttributeName:[UIColor blackColor]};
    navigationBarAppearance.titleTextAttributes = textAttributes;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}



@end
