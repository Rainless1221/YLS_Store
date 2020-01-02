//
//  NotificationService.m
//  StoreAV
//
//  Created by mocoo_ios on 2019/6/14.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "NotificationService.h"
//#import "UserModel.h"
//#import "FBHAppViewModel.h"
#import "JWBluetoothManage.h"

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>


@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@property (nonatomic, strong) AVSpeechSynthesizer *aVSpeechSynthesizer;
@property (strong,nonatomic)JWBluetoothManage * manage;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    self.aVSpeechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    self.manage = [JWBluetoothManage sharedInstance];


    // Modify the notification content here...
    //    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];

    
    NSDictionary *dict = self.bestAttemptContent.userInfo;
    
    
    NSString *type = dict[@"type"];
    NSDictionary *Dict =  dict[@"txt"];
    /*1、推送信息b判断、是否是订单*/
    if([type isEqualToString:@"get_paid_order"]){
       
        /*2、打印信息判断、是否开启*/
        NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.StoreAV"];
        NSString *isbluetooth =  [userDefault objectForKey:@"isbluetooth"];
        if ([isbluetooth isEqualToString:@"NO"]) {
            NSLog(@"没开启打印机连接开关!");
        }else{
            if (self.manage.stage != JWScanStageCharacteristics) {
                [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
                    if (!error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                        });
                    }else{
                        
                    }
                }];
            }else{
                [self printe:Dict];
            }

        }
        /*3、语言判断、是否开启*/
//        NSUserDefaults* userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.StoreAV"];
        NSString *Shake =  [userDefault objectForKey:@"isShakeOpen"];
        if ([Shake isEqualToString:@"NO"]) {
            
        }else{
//                    self.bestAttemptContent.sound = [UNNotificationSound soundNamed:@"叮咚，您有新的订单请及时处理.mp3"];
            //初始化一个供App Groups使用的NSUserDefaults对象
            NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"com.fanpay.TestStore.StoreAV"];
            
            //写入数据
            [userDefaults setValue:Dict[@"order_id"] forKey:@"AVorder_id"];
            
            //读取数据
            NSLog(@"推送的信息数据 ：%@", [userDefaults valueForKey:@"AVorder_id"]);
            
            
            //request 可以获取所有推送信息，里面可以取得播报内容
//            double i = [Dict[@"actual_money"] doubleValue];
//            double j = [Dict[@"service_money"] doubleValue];
//            double qian = i - j;
            NSString * jinEr=[NSString stringWithFormat:@"您有新的一鹿省订单,请及时处理!"];
            AVSpeechUtterance * aVSpeechUtterance = [[AVSpeechUtterance alloc] initWithString:jinEr];
            
            aVSpeechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
            aVSpeechUtterance.volume = 1;
            aVSpeechUtterance.voice =[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
            
            [self.aVSpeechSynthesizer speakUtterance:aVSpeechUtterance];
            
            self.contentHandler(self.bestAttemptContent);
        }
    }else{
        
    }
    

    
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}
//
#pragma mark - 打印
- (void)printe:(NSDictionary *)Dict{

#pragma mark - 打印小票的样式排版
    JWPrinter *printer = [[JWPrinter alloc] init];
//    [printer appendNewLine];
    [printer appendText:@"一鹿省商家小票" alignment:HLTextAlignmentLeft];
//    [printer appendNewLine];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
    NSString *table_number = [NSString stringWithFormat:@"%@",Dict[@"table_number"]];
    if ([table_number isEqualToString:@""]) {
        table_number = @"#";
    }
    [printer appendText:[NSString stringWithFormat:@"桌号：%@",table_number] alignment:HLTextAlignmentCenter fontSize:0x11];
    [printer appendText:[NSString stringWithFormat:@"*%@*",Dict[@"store_name"]] alignment:HLTextAlignmentCenter];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
    [printer appendText:[NSString stringWithFormat:@"序号:#%@ ",Dict[@"sort"]] alignment:HLTextAlignmentCenter fontSize:0x11];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
    NSString *Time = [NSString stringWithFormat:@"%@",Dict[@"add_time_full"]];
    NSArray *TimeArray = [Time componentsSeparatedByString:@" "];
    [printer appendTitle:[NSString stringWithFormat:@"下单时间：%@",TimeArray[0]] value:@"人数"];
    [printer appendTitle:[NSString stringWithFormat:@"%@",TimeArray[1]] value:[NSString stringWithFormat:@"%@",Dict[@"people_count"]] fontSize:0x11];
    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
    //    [printer appendSeperator_xing];
    [printer appendText:@"-----------订单信息-----------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
    [printer appendLeftText:@"名称" middleText:@"单价" rightText:@"数量" isTitle:YES];
    NSArray *goodsArr = Dict[@"goods_info"];
    for (int i =0; i<goodsArr.count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
        NSString *price = [NSString stringWithFormat:@"%@ ",goodsArr[i][@"goods_price"]];
        NSString *num =  [NSString stringWithFormat:@" x%@",goodsArr[i][@"goods_num"]];
        [printer YLSappendLeftText:name  alignment:HLTextAlignmentLeft fontSize:0x03 isTitle:NO];
        [printer setOffset:230];
        [printer YLSappendLeftText:price  alignment:HLTextAlignmentLeft fontSize:0x00 isTitle:NO];
        [printer setOffset:320 ];
        [printer YLSappendLeftText:num alignment:HLTextAlignmentLeft  fontSize:0x00 isTitle:YES];
    }
//    [printer appendNewLine];
    [printer appendSeperatorLine];
    [printer appendTitle:@"门店金额：" value:Dict[@"account_money"]];
    [printer appendTitle:@"服务费用：" value:Dict[@"service_money"]];
    [printer appendTitle:@"本单节省：" value:Dict[@"save_money"]];
    [printer appendTitle:@"用户实付：" value:[NSString stringWithFormat:@"%@",Dict[@"actual_money"]]];
//    [printer appendSeperatorLine];
    [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
    double i = [Dict[@"actual_money"] doubleValue];
    double j = [Dict[@"service_money"] doubleValue];
    double qian = i - j;
    //    [printer YLSappendLeftText:@"商家实收："  alignment:HLTextAlignmentLeft fontSize:10 isTitle:NO];
    //    [printer setOffset:270];
    //    [printer YLSappendLeftText:[NSString stringWithFormat:@"%.2f",qian]  alignment:HLTextAlignmentRight fontSize:20 isTitle:YES];
    [printer appendTitle:@"商家实收：" value:[NSString stringWithFormat:@"%.2f",qian] fontSize:0x01];
//    [printer appendSeperatorLine];
     [printer appendText:@"-------------------------------" alignment:HLTextAlignmentCenter];
//    [printer appendNewLine];
    [printer appendText:[NSString stringWithFormat:@"备注：%@",Dict[@"remark"]] alignment:HLTextAlignmentLeft fontSize:0x01];
    [printer appendText:@"*******************************" alignment:HLTextAlignmentCenter];
    [printer appendText:@"-----------其他信息-----------" alignment:HLTextAlignmentCenter];
//    [printer appendText:[NSString stringWithFormat:@"消费地址：%@",Dict[@"store_address"]] alignment:HLTextAlignmentLeft];
    NSString *phon = [NSString stringWithFormat:@"%@",Dict[@"user_info"][@"mobile"]];
    NSString *string = [NSString new];
    if ([phon isEqualToString:@""]) {
        phon = @"";
    }else{
        string = [phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    }
    NSString *UserString = [NSString stringWithFormat:@"%@(%@)",Dict[@"user_info"][@"user_name"],Dict[@"user_info"][@"sex"]];
    [printer appendText:[NSString stringWithFormat:@"用户信息：%@",UserString] alignment:HLTextAlignmentLeft];
    [printer appendText:[NSString stringWithFormat:@"用户号码：%@",string] alignment:HLTextAlignmentLeft];
    [printer appendText:[NSString stringWithFormat:@"订单编号：%@",Dict[@"order_sn"]] alignment:HLTextAlignmentLeft];
    NSString *paid = [NSString new];
    NSString *pid = [NSString stringWithFormat:@"%@",Dict[@"paid_type"]];
    if ([pid isEqualToString:@"4"]) {
        paid = @"余额支付";
    }else if ([pid isEqualToString:@"1"]){
        paid = @"支付宝支付";
    }else if ([pid isEqualToString:@"2"]){
        paid = @"微信支付";
    }else{
        paid = @"银行卡快捷支付";
    }
    [printer appendText:[NSString stringWithFormat:@"交易类型：%@",paid] alignment:HLTextAlignmentLeft];
    [printer appendSeperatorLine];
//    [printer appendNewLine];
    [printer appendText:@"感谢使用一鹿省，祝您生活愉快!\n下载一鹿省app全国走到哪省到哪" alignment:HLTextAlignmentCenter fontSize:0x00];
//    [printer appendNewLine];
//    [printer appendNewLine];
//    [printer appendNewLine];




    NSData *mainData = [printer getFinalData];

    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            NSLog(@"打印成功");
        }else{
            NSLog(@"写入错误---:%@",error);
            if (self.manage.stage != JWScanStageCharacteristics) {
                [self.manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
                    if (!error) {
                        dispatch_async(dispatch_get_main_queue(), ^{

                        });
                    }else{

                    }
                }];
            }
//            [self printe:Dict];

        }

    }];


}


@end
