//
//  BaseTabBarController.m
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/2/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseTabBarController.h"



@interface BaseTabBarController ()<FBHTabBarDelegate>

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.total_unread_news_num = @"0";
//    [self setTabbarController];
//    [self merchant_center];
    
    /*
     创建标签栏(原)
     */
    [self SetTabBar];
    /*
     设置标签栏
     */
    [self TabBarUp];

#pragma makr -- 提前加载
    for(UINavigationController *nav in  self.viewControllers){
        if ([self.viewControllers indexOfObject:nav] == 3) { // 指定需要加载的vc
            UIViewController *viewController = nav.viewControllers.firstObject;
            [viewController loadViewIfNeeded]; // 让其调用viewdidload
        }
        if ([self.viewControllers indexOfObject:nav] == 2) { // 指定需要加载的vc
            UIViewController *viewController = nav.viewControllers.firstObject;
            [viewController loadViewIfNeeded]; // 让其调用viewdidload
        }
        
        if ([self.viewControllers indexOfObject:nav] == 1) { // 指定需要加载的vc
            UIViewController *viewController = nav.viewControllers.firstObject;
            [viewController loadViewIfNeeded]; // 让其调用viewdidload
        }
    }
   
}
#pragma makr -- 设置标签栏
-(void)TabBarUp
{
    //默认界面
    self.selectedIndex = 0;
//    [self.tabBar  showBadgeOnItmIndex:3 tabbarNum:4];

}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}
/**
 *  tabbar实例
 */
- (void)setTabbarController{


    FBHCashierController *homeCtr = [[FBHCashierController alloc] init];
    BaseNavigationController *navCtr1 = [[BaseNavigationController alloc] initWithRootViewController:homeCtr];

    FBHWorkbenchController *disCtr = [[FBHWorkbenchController alloc] init];
    BaseNavigationController *navCtr2 = [[BaseNavigationController alloc] initWithRootViewController:disCtr];

    FBHStoreViewController *recCtr = [[FBHStoreViewController alloc] init];
    BaseNavigationController *navCtr3 = [[BaseNavigationController alloc] initWithRootViewController:recCtr];
    

    WordViewController *xiaoCtr = [[WordViewController alloc] init];
    BaseNavigationController *navCtr4 = [[BaseNavigationController alloc] initWithRootViewController:xiaoCtr];
    
    /*信息角标*/
//    dispatch_async(dispatch_get_main_queue(), ^{
//
//        homeCtr.navigationController.tabBarItem.badgeValue = @"1";
//
//    });

    [self.tabBar  showBadgeOnItmIndex:3 tabbarNum:4];


    
    NSArray *viewsArr = @[navCtr1,navCtr2,navCtr4,navCtr3];
    NSArray *itemTitleArr = @[@"收银台",@"工作台",@"消息",@"商家中心"];
    NSArray *itemImageArr = @[@"icn_tab_checkoout_normal",@"icn_tab_workbench_normal",@"icn_tab_message_normal",@"icn_tab_me_normal"];
    NSArray *itemSelectImageArr = @[@"icn_tab_checkoout_active",@"icn_tab_workbench_active",@"icn_tab_message_active",@"icn_tab_me_active"];
    
    [self setViewControllers:viewsArr];
    // 设置tabBarItem选中的颜色
    self.tabBar.tintColor = MainColor;
    for (int i = 0; i < viewsArr.count; i++) {
        
        UITabBarItem *item = [self.tabBar.items objectAtIndex:i];
        
        
        item.title = [NSString stringWithFormat:@"%@",itemTitleArr[i]];
        item.titlePositionAdjustment  = UIOffsetMake(0, -4);
        
        item.image = [UIImage imageNamed:itemImageArr[i]];
        // 设置选中时的图片,并修改图片渲染效果
        item.selectedImage = [[UIImage imageNamed:itemSelectImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (i == 1) {//工作台的位置
//            item.image = [[UIImage imageNamed:itemImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            item.selectedImage = [[UIImage imageNamed:itemSelectImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
//            selectAttrs[NSForegroundColorAttributeName] =  [UIColor whiteColor];
            [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
        }
    }

}

#pragma mark -- 创建标签栏
-(void)SetTabBar{
    FBHCashierController *activity1 = [[FBHCashierController alloc]init];
    [self addChildVC:activity1 title:@"收银台" image:@"icn_tab_checkoout_normal" selectImage:@"icn_tab_checkoout_active"];
    FBHWorkbenchController *activity2 = [[FBHWorkbenchController alloc]init];
    [self addChildVC:activity2 title:@"工作台" image:@"icn_tab_workbench_normal" selectImage:@"icn_tab_workbench_active"];
    WordViewController *activity3 = [[WordViewController alloc]init];
    [self addChildVC:activity3 title:@"消息" image:@"icn_tab_message_normal" selectImage:@"icn_tab_message_active"];
    FBHStoreViewController *activity4 = [[FBHStoreViewController alloc]init];
    [self addChildVC:activity4 title:@"商家中心" image:@"icn_tab_me_normal" selectImage:@"icn_tab_me_active"];

//    YlsCheckstandController *activity1 = [[YlsCheckstandController alloc]init];
//    [self addChildVC:activity1 title:@"收银台" image:@"icn_tab_checkoout_normal" selectImage:@"icn_tab_checkoout_active"];
//    FBHWorkbenchController *activity2 = [[FBHWorkbenchController alloc]init];
//    [self addChildVC:activity2 title:@"工作台" image:@"icn_tab_workbench_normal" selectImage:@"icn_tab_workbench_active"];
//    WordViewController *activity3 = [[WordViewController alloc]init];
//    [self addChildVC:activity3 title:@"消息" image:@"icn_tab_message_normal" selectImage:@"icn_tab_message_active"];
//    FBHStoreViewController *activity4 = [[FBHStoreViewController alloc]init];
//    [self addChildVC:activity4 title:@"商家中心" image:@"icn_tab_me_normal" selectImage:@"icn_tab_me_active"];
    

}
#pragma mark -- 创建标签栏方法
/**
 *  实例方法来创建标签栏
 *
 *  @param childVC     传入要添加的界面控制器
 *  @param title       界面的名称字符串
 *  @param image       按钮图片
 *  @param selectImage 选中状态按钮图片
 */
-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage;
{
    childVC.title = title;
    //正常按钮图片
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    
    //选中的按钮颜色,修改渲染
//    if ([title isEqualToString:@"工作台"]) {
////        childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"icn_tab_center_background_active"];
//
//    }
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //正常的字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [childVC.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    //选中的字体颜色
//    if ([title isEqualToString:@"工作台"]){
//        NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
//        selectAttrs[NSForegroundColorAttributeName] =  [UIColor whiteColor];
//        [childVC.tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
//    }else{
        NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
        selectAttrs[NSForegroundColorAttributeName] =  UIColorFromRGB(0xF7AE2B);
        [childVC.tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
//    }
    //包装导航栏
    BaseNavigationController *Nav = [[BaseNavigationController alloc]initWithRootViewController:childVC];
    //将导航栏添加到标签栏上
    [self addChildViewController:Nav];
    
}




#pragma mark 【 FBHTabBarDelegate 】
- (void)tabBarDidClickPlusButton:(FBHTabBar *)tabBar
{
    NSLog(@"点击工作台");
    FBHWorkbenchController *disCtr = [[FBHWorkbenchController alloc] init];
    BaseNavigationController *navCtr3 = [[BaseNavigationController alloc] initWithRootViewController:disCtr];
    [self presentViewController:navCtr3 animated:NO completion:nil];
    [self.tabBar bringSubviewToFront:self.view];
}


#pragma mark - 消息请求
-(void)merchant_center{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]list_news:model.merchant_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            self.total_unread_news_num = [NSString stringWithFormat:@"%@",DIC[@"total_unread_news_num"]];

        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{

    }];
    
    
}
@end
