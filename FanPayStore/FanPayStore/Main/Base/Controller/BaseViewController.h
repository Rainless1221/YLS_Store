//
//  BaseViewController.h
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/2/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWBluetoothManage.h"//打印机

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIButton *leftBackBtn;
@property (nonatomic, strong) UITableView * tableView;
@property (strong,nonatomic)JWBluetoothManage * manage;    //打印小票
@property(nonatomic,assign)BOOL isSoundOpen;//声音打开
@property(nonatomic,assign)BOOL isProjectSoundOpen;//声音打开
@property(nonatomic,assign)BOOL isShakeOpen;//震动打开
@property(nonatomic,assign)BOOL isRemindOpen;//提醒控制
/** 体现认证 */
@property (assign,nonatomic)NSInteger cust_type_with;
@property (assign,nonatomic)NSInteger status_With;


#pragma mark - 退出登录
-(void)Exit_log;
#pragma mark - 震动测试
- (void)shakeText:(UIButton *)sender;
#pragma mark -声音测试
- (void)soundText:(UIButton *)sender;
#pragma mark - 密码判断
- (NSString *)isOrNoPasswordStyle:(NSString *)passWordName;
#pragma mark - 密码的  大小写数字判断
- (BOOL)judgePassWordLegal:(NSString *)pass;
#pragma mark - 打印小票
-(void)JWPrinter_Printer:(NSDictionary *)Dict;
#pragma mark - 获取应用在 appStore的信息
-(void)lookup;
@end
