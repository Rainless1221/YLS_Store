//
//  FBHAppViewModel.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHAppViewModel.h"
#import "YBHttpTool.h"

@implementation FBHAppViewModel
//单利
+(instancetype)shareViewModel{
    static id instance;
    static  dispatch_once_t once;
    dispatch_once(&once, ^{
        instance=[[self alloc] init];
    });
    
    return instance;
    
}
/**
 获取服务器当前时间信息
 */
-(void)geTget_time_infoSuccess:(id (^)(NSDictionary *resDic))success
                    andfailure:(id (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    
    [YBHttpTool post:@"merchant_account/get_time_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
}
/**
 获取验证码
 */
-(void)geTcaptchaWithphone:(NSString *)phone
                   andtype:(NSString *)type
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:phone forKey:@"mobile"];
    [dic setValue:type forKey:@"type"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",phone,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    
    [YBHttpTool post:@"merchant_account/send_code" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
}
/**
 商家注册
 */
-(void)getRegisteruser:(NSString *)phone
               andcode:(NSString *)code
           andpassword:(NSString *)password
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:phone forKey:@"mobile"];
    [dic setValue:code forKey:@"code"];
    [dic setValue:[MD5Sign MD5:password] forKey:@"password"];
    [dic setValue:@"2" forKey:@"scene"];//iOS
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",phone,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/register" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 去登录
 */
-(void)userloginWithphone:(NSString *)phone
               andcaptcha:(NSString *)captcha
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure
{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:phone forKey:@"mobile"];
    [dic setValue:@"password" forKey:@"type"];
    [dic setValue:[MD5Sign MD5:captcha] forKey:@"password"];
    [dic setValue:@"2" forKey:@"scene"];//iOS
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",phone,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    
    [YBHttpTool post:@"merchant_account/login" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
    
}
//短信登录
-(void)userloginWithphone:(NSString *)phone
           andCodecaptcha:(NSString *)captcha
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:phone forKey:@"mobile"];
    [dic setValue:@"code" forKey:@"type"];
    [dic setValue:captcha forKey:@"code"];
    [dic setValue:@"2" forKey:@"scene"];//iOS
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",phone,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    
    [YBHttpTool post:@"merchant_account/login" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}

/**
 重置登录密码
 */
-(void)reset_login_password:(NSString *)phone
                    andcode:(NSString *)code
                andpassword:(NSString *)password
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:phone forKey:@"mobile"];
    [dic setValue:code forKey:@"code"];
    [dic setValue:[MD5Sign MD5:password] forKey:@"password"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",phone,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/reset_login_password" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 设置或重置支付密码
 */
-(void)set_payment_password:(NSString *)merchant_id
                    andcode:(NSString *)code
                andpassword:(NSString *)password
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:code forKey:@"code"];
    [dic setValue:[MD5Sign MD5:password] forKey:@"password"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/set_payment_password" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}


/**
 更改绑定手机号
 */
-(void)change_binded_mobile:(NSString *)merchant_id
                    andcode:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    for (NSString *key in Dict) {
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/change_binded_mobile" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
}
/**
 判断支付密码是否存在
 */
-(void)is_exist_pay_pwd:(NSString *)merchant_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure
{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/is_exist_pay_pwd" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}

/**
 验证支付密码是否正确
 */
-(void)verify_payment_password:(NSString *)merchant_id
                   andpassword:(NSString *)password
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:[MD5Sign MD5:password] forKey:@"password"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/verify_payment_password" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 设置或重置支付密码前 验证原支付密码或验证码
 */
-(void)verify_old_pwd_or_code_before_set_payment_password:(NSString *)merchant_id
                                                   andkey:(NSString *)key
                                                andsiring:(NSString *)siring
                                                  Success:(void (^)(NSDictionary *resDic))success
                                               andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:siring forKey:key];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_account/verify_old_pwd_or_code_before_set_payment_password" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}



#pragma mark - 商家中心

/**
 登录成功后 获取商家中心的信息（商家中心显示的信息）
 */
-(void)list_business_center:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_business_center" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 获取店铺ID
 */
-(void)get_store_id:(NSString *)merchant_id
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_store_id" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 判断店铺名称是否已存在
 */
-(void)is_exist_store_name:(NSString *)merchant_id
             andstore_name:(NSString *)store_name
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_name forKey:@"store_name"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/is_exist_store_name" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
}

/**
 是否提示：添加翻呗活动或优惠商品
 */
-(void)tips_for_merchant_about_discount_goods:(NSString *)merchant_id
                                  andstore_id:(NSString *)store_id
                                      Success:(void (^)(NSDictionary *resDic))success
                                   andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/tips_for_merchant_about_discount_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 获取店铺申请信息
 */
-(void)get_store_application_info:(NSString *)merchant_id
                          Success:(void (^)(NSDictionary *resDic))success
                       andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_store_application_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 获取店铺申请信息（已通过审核） 接口
 */
-(void)get_store_application_pass_info:(NSString *)merchant_id
                               Success:(void (^)(NSDictionary *resDic))success
                            andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_store_application_pass_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 添加商户入驻申请信息
 
 商家入驻接口,该接口可多次调用，
 每次完善部分信息。 需填写店铺名称，
 选择经营类型，上传店铺logo，
 选择或填写店铺地址、门牌号、联系人姓名、联系人手机号、联系人固定电话，上传门脸照片（可看见门匾、门框）、店内环境照片（包含桌椅、收银台等），
 上传法人手持身份证照片，
 上传营业执照图片，
 上传经营许可证图片
 */
-(void)insert_store_application:(NSString *)merchant_id
                andMerchantDict:(NSDictionary *)Dict
                        Success:(void (^)(NSDictionary *resDic))success
                     andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
//    [dic setValue:Dict[@"store_name"] forKey:@"store_name"];
//    [dic setValue:Dict[@"category_id"] forKey:@"category_id"];
//
//    NSString *sec  = [NSString stringWithFormat:@"%@",Dict[@"sec_category_id"]];
//    if ([[MethodCommon judgeStringIsNull:sec] isEqualToString:@""]) {
//
//    }else{
//        [dic setValue:Dict[@"sec_category_id"] forKey:@"sec_category_id"];
//    }
//    [dic setValue:Dict[@"store_logo"] forKey:@"store_logo"];
//    [dic setValue:Dict[@"store_address"] forKey:@"store_address"];
//    [dic setValue:Dict[@"lon"] forKey:@"lon"];
//    [dic setValue:Dict[@"lat"] forKey:@"lat"];
//    [dic setValue:Dict[@"specific_location"] forKey:@"specific_location"];
//    [dic setValue:Dict[@"reminder"] forKey:@"reminder"];
//    [dic setValue:Dict[@"reminder2"] forKey:@"reminder2"];
//    [dic setValue:Dict[@"merchant_name"] forKey:@"merchant_name"];
//    [dic setValue:Dict[@"merchant_mobile"] forKey:@"merchant_mobile"];
//    [dic setValue:Dict[@"merchant_telephone"] forKey:@"merchant_telephone"];
//    [dic setValue:Dict[@"door_face_pic"] forKey:@"door_face_pic"];
//    [dic setValue:Dict[@"store_environment_pics"] forKey:@"store_environment_pics"];
//    [dic setValue:Dict[@"hand_held_ID_card_pic"] forKey:@"hand_held_ID_card_pic"];
//    [dic setValue:Dict[@"business_license_pic"] forKey:@"business_license_pic"];
//    [dic setValue:Dict[@"business_permit_pic"] forKey:@"business_permit_pic"];
//    /*经营时间*/
//    [dic setValue:Dict[@"business_hours"] forKey:@"business_hours"];
//    [dic setValue:Dict[@"business_times"] forKey:@"business_times"];
    
    
    for (NSString *key in Dict) {
//        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    
    [YBHttpTool post:@"merchant_center/insert_store_application" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 上传图片
 */
-(void)uploadPicturesOss:(NSString *)merchant_id
           andpicture:(NSString *)picture
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/uploadPicturesOss" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}



/**
 获取供选择的店铺类型数据
 */
-(void)get_store_category_info:(NSString *)merchant_id
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_store_category_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 根据一级分类ID获取二级分类
 */
-(void)get_sec_store_category_info:(NSString *)merchant_id
                    andcategory_id:(NSString *)category_id
                           Success:(void (^)(NSDictionary *resDic))success
                        andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:category_id forKey:@"category_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_sec_store_category_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取商家账户信息
 */
-(void)get_merchant_info:(NSString *)merchant_id
             andstore_id:(NSString *)store_id
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_merchant_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取商户店铺粉丝信息 获取店铺的关注者的信息
 */
-(void)list_store_fans:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
               andpage:(NSString *)page
              andlimit:(NSString *)limit
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:page forKey:@"page"];
    [dic setValue:limit forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_classification_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取间接粉丝信息、获取粉丝的粉丝信息 接口
 */
-(void)get_sec_class_fans_info:(NSString *)merchant_id
                    anduser_id:(NSString *)user_id
                   andstore_id:(NSString *)user_type
                       andpage:(NSString *)page
                      andlimit:(NSString *)limit
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];

    [dic setValue:user_id forKey:@"user_id"];
    [dic setValue:user_type forKey:@"user_type"];
    [dic setValue:page forKey:@"page"];
    [dic setValue:limit forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_sec_class_fans_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 发布商品
 */
-(void)insert_goods:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andGoodDict:(NSDictionary *)Dict
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"goods_name"] forKey:@"goods_name"];
    [dic setValue:Dict[@"goods_price"] forKey:@"goods_price"];
    [dic setValue:Dict[@"discount_price"] forKey:@"discount_price"];
    [dic setValue:Dict[@"goods_num"] forKey:@"goods_num"];
    [dic setValue:Dict[@"goods_description"] forKey:@"goods_description"];
    [dic setValue:Dict[@"goods_pic"] forKey:@"goods_pic"];
    [dic setValue:Dict[@"category_id"] forKey:@"category_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/insert_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 商家中心-商家产品信息
 */
-(void)list_merchant_goods:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
             andis_on_sale:(NSString *)is_on_sale
            andcategory_id:(NSString *)category_id
                   andpage:(NSString *)page
                  andlimit:(NSString *)limit
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:is_on_sale forKey:@"is_on_sale"];
    [dic setValue:category_id forKey:@"category_id"];
    
    [dic setValue:page forKey:@"page"];
    [dic setValue:limit forKey:@"limit"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_merchant_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 根据商品ID获取商品信息
 */
-(void)get_goods_info:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
          andgoods_id:(NSString *)goods_id
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:goods_id forKey:@"goods_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_goods_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 上架或下架商品
 */
-(void)set_goods_sale_type:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               andgoods_id:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"goods_id"] forKey:@"goods_id"];
    [dic setValue:Dict[@"set_sale_type"] forKey:@"set_sale_type"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/set_goods_sale_type" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 删除商品（已下架的商品）
 */
-(void)delete_goods:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andgoods_id:(NSArray *)idArray
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    NSString *Arraystr = [[NSString alloc]init];
    
    for (NSString *goodis in idArray) {
        NSString *idstr = [NSString stringWithFormat:@"%@,",goodis];
        Arraystr = [Arraystr stringByAppendingString:idstr];
    }
    [dic setValue:Arraystr forKey:@"goods_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取翻呗设置列表信息
 */
-(void)list_goods_discount:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               anddiscount:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"type"] forKey:@"type"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_goods_discount" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 添加或编辑店铺翻呗活动、翻呗设置
 */
-(void)insert_update_store_discount:(NSString *)merchant_id
                        andstore_id:(NSString *)store_id
                        anddiscount:(NSDictionary *)Dict
                            Success:(void (^)(NSDictionary *resDic))success
                         andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"discount_type"] forKey:@"discount_type"];
    [dic setValue:Dict[@"discount_condition"] forKey:@"discount_condition"];
    [dic setValue:Dict[@"begin_date"] forKey:@"begin_date"];
    [dic setValue:Dict[@"begin_time"] forKey:@"begin_time"];
    [dic setValue:Dict[@"end_date"] forKey:@"end_date"];
    [dic setValue:Dict[@"end_time"] forKey:@"end_time"];
    [dic setValue:Dict[@"discount_id"] forKey:@"discount_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/insert_update_store_discount" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 获删除翻呗活动
 */
-(void)delete_store_discount:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSString *)discount
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:discount forKey:@"discount_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_store_discount" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取翻呗设置详情
 */
-(void)detail_goods_discount:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSDictionary *)Dict
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"discount_id"] forKey:@"discount_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/detail_goods_discount" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 获取优惠商品列表信息
 */
-(void)list_store_discount_goods:(NSString *)merchant_id
                     andstore_id:(NSString *)store_id
                     anddiscount:(NSDictionary *)Dict
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"discount_id"] forKey:@"discount_id"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_store_discount_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 添加优惠商品
 */
-(void)insert_discount_goods:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSDictionary *)Dict
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"discount_id"] forKey:@"discount_id"];
    [dic setValue:Dict[@"goods_id"] forKey:@"goods_id"];
    [dic setValue:Dict[@"discount_price"] forKey:@"discount_price"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/insert_discount_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 删除优惠商品
 */
-(void)delete_discount_goods:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSDictionary *)Dict
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"d_goods_id"] forKey:@"d_goods_id"];
    [dic setValue:Dict[@"discount_id"] forKey:@"discount_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_discount_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取订单列表信息
 */
-(void)list_merchant_orders:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                  andorders:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"order_status"] forKey:@"order_status"];
    [dic setValue:Dict[@"begin_date"] forKey:@"begin_date"];
    [dic setValue:Dict[@"end_date"] forKey:@"end_date"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    
    [YBHttpTool post:@"merchant_center/list_merchant_orders" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取订单详情
 */
-(void)detail_merchant_orders:(NSString *)merchant_id
                  andorder_id:(NSString *)order_id
                      Success:(void (^)(NSDictionary *resDic))success
                   andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:order_id forKey:@"order_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/detail_merchant_orders" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}


/**
 获取消息中心信息
 */
-(void)list_news:(NSString *)merchant_id
         Success:(void (^)(NSDictionary *resDic))success
      andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_news" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取某类型的消息列表
 */
-(void)list_news_info:(NSString *)merchant_id
              andDict:(NSDictionary *)Dict
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    [dic setValue:Dict[@"news_type"] forKey:@"news_type"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_news_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 获取消息详情
 */
-(void)detail_news_info:(NSString *)merchant_id
             andnews_id:(NSString *)news_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:news_id forKey:@"news_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/detail_news_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 全部忽略：将未读的设为已读 接口
 */
-(void)set_news_read:(NSString *)merchant_id
             andDict:(NSDictionary *)Dict
             Success:(void (^)(NSDictionary *resDic))success
          andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    for (NSString *key in Dict) {
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/set_news_read" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 编辑商品
 */
-(void)edit_goods:(NSString *)merchant_id
      andstore_id:(NSString *)store_id
          andgood:(NSDictionary *)Dict
          Success:(void (^)(NSDictionary *resDic))success
       andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"goods_id"] forKey:@"goods_id"];
    [dic setValue:Dict[@"goods_name"] forKey:@"goods_name"];
    [dic setValue:Dict[@"goods_price"] forKey:@"goods_price"];
    [dic setValue:Dict[@"discount_price"] forKey:@"discount_price"];
    [dic setValue:Dict[@"goods_num"] forKey:@"goods_num"];
    [dic setValue:Dict[@"goods_description"] forKey:@"goods_description"];
    [dic setValue:Dict[@"goods_pic"] forKey:@"goods_pic"];
    [dic setValue:Dict[@"category_id"] forKey:@"category_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/edit_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 商家回复用户
 */
-(void)merchant_reply_order_evaluate:(NSString *)merchant_id
                         andstore_id:(NSString *)store_id
                         andorder_id:(NSString *)order_id
                          andcontent:(NSString *)content
                             Success:(void (^)(NSDictionary *resDic))success
                          andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:order_id forKey:@"order_id"];
    [dic setValue:content forKey:@"content"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/merchant_reply_order_evaluate" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 订单回复列表
 */
-(void)list_order_reply:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
            andorder_id:(NSString *)order_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:order_id forKey:@"order_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_order_reply" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 删除订单 接口
 */
-(void)delete_order:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andorder_id:(NSString *)order_id
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:order_id forKey:@"order_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_order" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取商品分类信息 接口
 */
-(void)list_goods_category:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_goods_category" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 添加商品分类 接口
 */
-(void)add_goods_category:(NSString *)merchant_id
              andstore_id:(NSString *)store_id
         andcategory_name:(NSString *)category_name
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:category_name forKey:@"category_name"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/add_goods_category" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 删除商品分类 接口
 */
-(void)delete_goods_category:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
              andcategory_id:(NSString *)category_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:category_id forKey:@"category_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_goods_category" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 编辑商品分类 接口
 */
-(void)edit_goods_category:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
            andcategory_id:(NSString *)category_id
          andcategory_name:(NSString *)category_name
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:category_id forKey:@"category_id"];
    [dic setValue:category_name forKey:@"category_name"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/edit_goods_category" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 获取店铺温馨提示信息 接口
 */
-(void)get_store_tips:(NSString *)merchant_id
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_store_tips" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 获取分店信息接口
 */
-(void)get_branch_store_info:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
              andbranch_type:(NSString *)branch_type
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
 
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:branch_type forKey:@"branch_type"];

    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_branch_store_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 获取单个分店信息接口
 */
-(void)get_one_branch_store:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
           andbranch_mer_id:(NSString *)branch_mer_id
         andbranch_store_id:(NSString *)branch_store_id
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:branch_mer_id forKey:@"branch_mer_id"];
    [dic setValue:branch_store_id forKey:@"branch_store_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_one_branch_store" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}


/**
 添加分店 接口
 */
-(void)add_branch_store:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
            andbankDict:(NSDictionary *)Dict
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
//        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/add_branch_store" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 删除分店 接口
 */
-(void)delete_branch_store:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               andbankDict:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_branch_store" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 切换分店时更新令牌信息（生成时间），防止切换后退出登录的情况发生 接口
 */
-(void)update_token_info_when_switch_store:(NSString *)merchant_id
                               andstore_id:(NSString *)store_id
                               andbankDict:(NSDictionary *)Dict
                                   Success:(void (^)(NSDictionary *resDic))success
                                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/update_token_info_when_switch_store" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 添加银盛子商户注册信息 接口
 */
-(void)add_ysepay_merchant_info:(NSString *)merchant_id
                    andstore_id:(NSString *)store_id
                    andbankDict:(NSDictionary *)Dict
                        Success:(void (^)(NSDictionary *resDic))success
                     andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        NSString *Str = [NSString stringWithFormat:@"%@",Dict[key]];
        if ( [[MethodCommon judgeStringIsNull:Str] isEqualToString:@""]) {
            
        }else{
            [dic setValue:Str forKey:key];

        }
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_ysepay/add_ysepay_merchant_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取银盛子商户注册信息（未审核通过的） 接口
 */
-(void)get_ysepay_merchant_info:(NSString *)merchant_id
                    andstore_id:(NSString *)store_id
                        Success:(void (^)(NSDictionary *resDic))success
                     andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_ysepay/get_ysepay_merchant_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 获取提现账户信息完成情况 接口
 */
-(void)get_completion_ysepay_mer_info:(NSString *)merchant_id
                          andstore_id:(NSString *)store_id
                              Success:(void (^)(NSDictionary *resDic))success
                           andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_ysepay/get_completion_ysepay_mer_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 获取各银行信息 接口
 */
-(void)get_bank_info:(NSString *)merchant_id
         andstore_id:(NSString *)store_id
             Success:(void (^)(NSDictionary *resDic))success
          andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_ysepay/get_bank_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取省份城市信息 接口
 */
-(void)get_province_and_city:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_ysepay/get_province_and_city" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 获取支行信息：根据省份城市和所属银行 接口
 */
-(void)get_branch_bank:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
           andprovince:(NSString *)province
               andcity:(NSString *)city
          andbank_name:(NSString *)bank_name
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure
{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:province forKey:@"province"];
    [dic setValue:city forKey:@"city"];
    [dic setValue:bank_name forKey:@"bank_name"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_ysepay/get_branch_bank" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
#pragma mark - 工作台
/**
 获取工作台上半部分信息 如当日收银、当日订单、当日预定、待办事项、累计访客、成功转化率等
 */
-(void)get_workbench_upper_part_info:(NSString *)merchant_id
                         andstore_id:(NSString *)store_id
                             Success:(void (^)(NSDictionary *resDic))success
                          andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/get_workbench_upper_part_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}


/**
 获取工作台信息 下半部分信息 如店铺订单统计、店铺访客统计
 */
-(void)get_workbench_lower_part_info:(NSString *)merchant_id
                         andstore_id:(NSString *)store_id
                      andsearch_date:(NSString *)search_date
                             Success:(void (^)(NSDictionary *resDic))success
                          andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:search_date forKey:@"search_date"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/get_workbench_lower_part_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 生成店铺二维码
 */
-(void)generate_store_qrcode:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/get_store_share_qrcode" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
    
}
/**
 获取到店消费码
 */
-(void)get_into_store_qrcode:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/get_into_store_qrcode" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 商户端扫描订单二维码后进行确认处理
 */
-(void)use_order_code:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
         andparameter:(NSString *)parameter
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    /**
     http://fanbuy.imocoo.com/api/store_order/use_order_code?parameter=+2dUt7RuwbnT0zN6tuUg/GG9Uz7V6PCXWDWeHlSnu5dDrA5UkWrHwhEy/DL1WNZvyK29JVr7ydyBj1FP2eYdvQ==
     **/
    
    NSString *URL = [NSString stringWithFormat:@"%@&store_id=%@ &merchant_id=%@&timestamp=%@&process=%@&token=%@",parameter,store_id,merchant_id,timestamp,[MD5Sign MD5:process],model.token];
    
    
    [YBHttpTool get:URL params:nil success:^(NSDictionary *obj) {
        
        success(obj);
        
    } failure:^(NSError *error) {
        
        failure();
        
    }];
    
    
}
/**
 商户确认订单：输入订单验证码
 */
-(void)input_order_code:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
          andorder_code:(NSString *)order_code
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:order_code forKey:@"order_code"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/input_order_code" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
}
/**
 设置店铺状态 接口
 */
-(void)set_store_status:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
        andstore_status:(NSString *)store_status
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:store_status forKey:@"store_status"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/set_store_status" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
}
/**
 获取桌码列表信息 接口
 */
-(void)list_table_number:(NSString *)merchant_id
             andstore_id:(NSString *)store_id
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/list_table_number" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
}
/**
 生成桌码 接口
 */
-(void)create_table_number_qrcode:(NSString *)merchant_id
                      andstore_id:(NSString *)store_id
                  andtable_number:(NSString *)table_number
                          Success:(void (^)(NSDictionary *resDic))success
                       andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:table_number forKey:@"table_number"];

    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/create_table_number_qrcode" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
    
}


/**
 删除桌码 接口
 */
-(void)delete_table_number:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                 andt_n_id:(NSString *)t_n_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:t_n_id forKey:@"t_n_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_workbench/delete_table_number" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
    }];
    
    
}
#pragma mark - 收银台
/**
 获取收银台基本信息
 */
-(void)get_checkstand_info:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yls_merchant_checkstand/get_checkstand_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
    
}

/**
 获取收银台收支及某天收支列表信息
 */
-(void)list_checkstand_consumption:(NSString *)merchant_id
                       andstore_id:(NSString *)store_id
                       andlistDict:(NSDictionary *)Dict
                           Success:(void (^)(NSDictionary *resDic))success
                        andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
//    [dic setValue:Dict[@"begin_date"] forKey:@"begin_date"];
//    [dic setValue:Dict[@"end_date"] forKey:@"end_date"];
//    [dic setValue:Dict[@"type"] forKey:@"type"];
//    [dic setValue:Dict[@"consumption_date"] forKey:@"consumption_date"];
//    [dic setValue:Dict[@"account_interval"] forKey:@"account_interval"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yls_merchant_checkstand/list_checkstand_consumption" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 提现页面信息
 */
-(void)get_withdrawal_info:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_checkstand/get_withdrawal_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 提交提现申请
 */
-(void)insert_withdraw_info:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                andlistDict:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
//    [dic setValue:Dict[@"account_name"] forKey:@"account_name"];
//    [dic setValue:Dict[@"bank_card_id"] forKey:@"bank_card_id"];
//    [dic setValue:Dict[@"withdraw_amount"] forKey:@"withdraw_amount"];
    //    [dic setValue:Dict[@"remark"] forKey:@"remark"];
    
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_checkstand/insert_withdraw_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 验证验证码 提交提现申请前 接口
 */
-(void)verify_code_before_insert_withdraw_info:(NSString *)merchant_id
                                   andstore_id:(NSString *)store_id
                                   andlistDict:(NSDictionary *)Dict
                                       Success:(void (^)(NSDictionary *resDic))success
                                    andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_checkstand/verify_code_before_insert_withdraw_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 获取提现记录
 */
-(void)get_withdrawals_log:(NSString *)merchant_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_checkstand/get_withdrawals_log" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 获取 营收记录列表
 */
-(void)list_checkstand_revenue:(NSString *)merchant_id
                   andstore_id:(NSString *)store_id
                   andlistDict:(NSDictionary *)Dict
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:Dict[@"end_date"] forKey:@"end_date"];
    [dic setValue:Dict[@"type"] forKey:@"type"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_checkstand/list_checkstand_revenue" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 获取某条营收记录详情
 */
-(void)get_checkstand_revenue:(NSString *)merchant_id
                  andstore_id:(NSString *)store_id
                  andlistDict:(NSDictionary *)Dict
                      Success:(void (^)(NSDictionary *resDic))success
                   andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:Dict[@"log_id"] forKey:@"log_id"];
    [dic setValue:Dict[@"type"] forKey:@"type"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_checkstand/get_checkstand_revenue" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}









#pragma mark - 特惠活动
/**
 获取特惠活动列表信息 接口
 */
-(void)list_preferential_activities:(NSString *)merchant_id
                        andstore_id:(NSString *)store_id
                        andbankDict:(NSDictionary *)Dict
                            Success:(void (^)(NSDictionary *resDic))success
                         andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
//        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/list_preferential_activities" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 添加或编辑店铺特惠活动 接口
 */
-(void)insert_update_preferential_activities:(NSString *)merchant_id
                                 andstore_id:(NSString *)store_id
                                 andbankDict:(NSDictionary *)Dict
                                     Success:(void (^)(NSDictionary *resDic))success
                                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    for (NSString *key in Dict) {
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/insert_update_preferential_activities" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
   
    
    
}


/**
 添加特惠商品 接口
 */
-(void)insert_preferential_goods:(NSString *)merchant_id
                     andstore_id:(NSString *)store_id
                     andbankDict:(NSDictionary *)Dict
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure{
 
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
//        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/insert_preferential_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 删除特惠商品 接口
 */
-(void)delete_preferential_goods:(NSString *)merchant_id
                     andstore_id:(NSString *)store_id
                     andbankDict:(NSDictionary *)Dict
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure{
    
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
//        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_preferential_goods" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}



/**
 获取特惠活动详情 接口
 */
-(void)get_preferential_detail:(NSString *)merchant_id
                   andstore_id:(NSString *)store_id
            andpreferential_id:(NSString *)preferential_id
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:preferential_id forKey:@"preferential_id"];

    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_preferential_detail" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 删除特惠活动 接口
 */
-(void)delete_preferential_activity:(NSString *)merchant_id
                        andstore_id:(NSString *)store_id
                 andpreferential_id:(NSString *)preferential_id
                            Success:(void (^)(NSDictionary *resDic))success
                         andfailure:(void (^)(void))failure{
    
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:preferential_id forKey:@"preferential_id"];
    
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/delete_preferential_activity" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}



#pragma mark - 标签
/**
 为商品分类（标签）排序
 */
-(void)sort_goods_category:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
          andcategory_sort:(NSDictionary *)array
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in array) {
        //        NSLog(@"%@",key);
        
        [dic setValue:array[key] forKey:key];
    }
//    [dic setValue:array forKey:@"category_sort"];

    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/sort_goods_category" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
    
}

#pragma mark - 服务中心
/**
 根据银行卡号获取所属银行
 */
-(void)get_bank_name_by_card_num:(NSString *)merchant_id
                  andcard_number:(NSString *)card_number
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:card_number forKey:@"card_number"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/get_bank_name_by_card_num" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 获取银行列表信息
 */
-(void)list_bank_info:(NSString *)merchant_id
              andpage:(NSString *)page
             andlimit:(NSString *)limit
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:page forKey:@"page"];
    [dic setValue:limit forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/list_bank_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取银行卡信息
 */
-(void)list_merchant_bank_card:(NSString *)merchant_id
                       andpage:(NSString *)page
                      andlimit:(NSString *)limit
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:page forKey:@"page"];
    [dic setValue:limit forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/list_merchant_bank_card" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 添加银行卡
 */
-(void)insert_bank_card:(NSString *)merchant_id
            andbankDict:(NSDictionary *)Dict
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:Dict[@"bank_name"] forKey:@"bank_name"];
    [dic setValue:Dict[@"bank_code"] forKey:@"bank_code"];
    [dic setValue:Dict[@"card_number"] forKey:@"card_number"];
    [dic setValue:Dict[@"card_property"] forKey:@"card_property"];
    [dic setValue:Dict[@"name"] forKey:@"name"];
    [dic setValue:Dict[@"mobile"] forKey:@"mobile"];
    [dic setValue:Dict[@"ID_card_num"] forKey:@"ID_card_num"];

    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/insert_bank_card" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 添加银行卡前的验证码验证 接口
 */
-(void)verify_code_before_insert_bank_card:(NSString *)merchant_id
                               andstore_id:(NSString *)store_id
                               andbankDict:(NSDictionary *)Dict
                                   Success:(void (^)(NSDictionary *resDic))success
                                andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    [YBHttpTool post:@"service_center/verify_code_before_insert_bank_card" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 删除商户银行卡
 */
-(void)delete_bank_card:(NSString *)merchant_id
             andcard_id:(NSString *)card_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:card_id forKey:@"card_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/delete_bank_card" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 获取当前版本信息 商户端
 */
-(void)get_mer_version_info:(NSString *)merchant_id
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/get_mer_version_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 获取帮助与客服页面问题列表
 */
-(void)list_common_problem:(NSString *)merchant_id
                andproblem:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    
    [dic setValue:@"2" forKey:@"type"];
    [dic setValue:Dict[@"page"] forKey:@"page"];
    [dic setValue:Dict[@"limit"] forKey:@"limit"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/list_common_problem" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}


/**
 获取帮助与客服页面问题详情
 */
-(void)detail_common_problem:(NSString *)merchant_id
               andproblem_id:(NSString *)problem_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:problem_id forKey:@"problem_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/detail_common_problem" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
    
}

/**
 提交加盟代理信息
 */
-(void)insert_join_agent:(NSString *)merchant_id
             andstore_id:(NSString *)store_id
             andjoinDict:(NSDictionary *)Dict
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    [dic setValue:Dict[@"merchant_name"] forKey:@"merchant_name"];
    [dic setValue:Dict[@"merchant_mobile"] forKey:@"merchant_mobile"];
    [dic setValue:Dict[@"merchant_email"] forKey:@"merchant_email"];
    [dic setValue:Dict[@"store_address"] forKey:@"store_address"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/insert_join_agent" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}





#pragma mark - 上传图片
-(void)uploadImageWithData:(UIImage *)image
                   andtype:(NSString *)type
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //    [SVProgressHUD showWithStatus:@"正在上传"];
    [MBProgressHUD MBProgress:@"正在上传..."];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"multipart/form-data",
                                                         @"text/json",
                                                         nil];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头，也可以不设置
    [manager.requestSerializer setValue:@"text/plain;charset=utf-8;application/octet-stream;multipart/form-data;" forHTTPHeaderField:@"Content-Type"];
    
    
    UserModel *model=[UserModel getUseData];
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    NSString *process = [NSString stringWithFormat:@"%@%@",model.merchant_id,timestamp];
    NSData *imageData = UIImageJPEGRepresentation(image,0.4);
    NSDictionary *dic=@{
                        @"merchant_id":model.merchant_id,
                        @"timestamp":timestamp,
                        @"type":@"",
                        @"process":[MD5Sign MD5:process],
                        @"token":model.token,
                        };
    
    NSMutableDictionary *Mdic=[NSMutableDictionary dictionaryWithDictionary:dic];
    NSString *URl = [NSString stringWithFormat:@"merchant_center/uploadPicturesOss"];
    
    NSString * URLpublic = [PublicMethods readFromUserD:@"URL_addin"];
    NSString *KAPURL = [NSString new];
    if ([URLpublic  isEqualToString:@"1"]) {
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL];
    }else{
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL1];
        
    }
    NSString *httpStr = [[ KAPURL stringByAppendingString:URl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:httpStr parameters:Mdic constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"picture[]"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
        //        dispatch_sync(dispatch_get_main_queue(), ^{
        //            NSLog(@" 上传进度 progress is %@",uploadProgress);
        //        });
        
    } success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject) {
        //        [SVProgressHUD dismiss];
        [MBProgressHUD hideHUD];
        
        //上传成功
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //        self.store_logo = [NSString stringWithFormat:@"%@",dict[@"data"][@"img_url"]];
        success(dict);
        
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        //        [SVProgressHUD dismiss];
        [MBProgressHUD hideHUD];
        
        //上传失败
        NSLog(@"error=%@",error);
        failure();
        
    }];
    
    
    
}



#pragma mark -  获取当前时间戳
+ (NSString *)currentTimeStr{

    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time= [date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    
    

    __block NSString *objectID;


        [[FBHAppViewModel shareViewModel]geTget_time_infoSuccess:^id(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1){
                
                objectID = [NSString stringWithFormat:@"%@",resDic[@"data"][@"now_timestamp"]];
                [PublicMethods writeToUserD:objectID andKey:@"now_timestamp" ];

            }else{
                objectID = [NSString stringWithFormat:@"%.0f", time];
            }
            
            return objectID;
            
        } andfailure:^{
            return objectID;

        }];

    objectID = [PublicMethods readFromUserD:@"now_timestamp"];

    if ([[MethodCommon judgeStringIsNull:objectID] isEqualToString:@""]) {
        objectID= [NSString stringWithFormat:@"%.0f", time];

    }else{
        NSInteger T = time - [objectID integerValue];
        
        if ( T  >60) {
            
            
            objectID= [NSString stringWithFormat:@"%.0f", time];
            
            
            
            
        }
        
    }
    
    return objectID;

    
}




#pragma mark ---------------------------------------- 一鹿省 ------------------------------

/**
  登录成功后 获取商家中心的信息（商家中心显示的信息） 接口
  */
-(void)yls_list_business_center:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yls_merchant_center/list_business_center" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 获取工作台基本信息 接口
 */
-(void)yls_get_workbench_info:(NSString *)merchant_id
                  andstore_id:(NSString *)store_id
                      Success:(void (^)(NSDictionary *resDic))success
                   andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yls_merchant_workbench/get_workbench_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 商家打印机终端绑定 接口
 */
-(void)binding_pinter:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
          andjoinDict:(NSDictionary *)Dict
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yly_receipts/binding_pinter" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}

/**
 获取商家打印机终端列表 接口
 */
-(void)pinter_list:(NSString *)merchant_id
       andstore_id:(NSString *)store_id
           Success:(void (^)(NSDictionary *resDic))success
        andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    

    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yly_receipts/pinter_list" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 商家打印机终端解绑 接口
 */
-(void)unbinding_pinter:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
          andprinter_id:(NSString *)printer_id
        andmachine_code:(NSString *)machine_code
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:printer_id forKey:@"printer_id"];
    [dic setValue:machine_code forKey:@"machine_code"];

    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yly_receipts/unbinding_pinter" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 开启/关闭 商家打印机 接口
 开关命令：1开启，2关闭
 */
-(void)shutdownRestart:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
      andresponse_type:(NSString *)response_type
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:response_type forKey:@"response_type"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yly_receipts/shutdownRestart" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 商家打印机 进行打印 接口
 */
-(void)YlyReceipts:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andorder_id:(NSString *)order_id
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:order_id forKey:@"order_id"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"yly_receipts/front_pinter" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

#pragma mark - 分账认证
/**
 获取已有的银行卡资料 接口
 */
-(void)get_bank_card_info:(NSString *)merchant_id
              andstore_id:(NSString *)store_id
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_xib_division/get_bank_card_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
    
    
}
/**
 获取分账认证银行卡信息 接口
 */
-(void)list_bank_card_info:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    
    
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_xib_division/list_bank_card_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}

/**
 获取厦门国际银行 银行名称和行号信息 接口
 */
-(void)get_xib_bank_info:(NSString *)merchant_id
             andstore_id:(NSString *)store_id
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_xib_division/get_xib_bank_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 注册个人客户账户 接口
 */
-(void)exec_register_non_enterprise_account:(NSString *)merchant_id
                                andstore_id:(NSString *)store_id
                                andjoinDict:(NSDictionary *)Dict
                                    Success:(void (^)(NSDictionary *resDic))success
                                 andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_xib_division/exec_register_non_enterprise_account" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}


/**
 注册企业客户账户（对公银行卡） 接口
 */
-(void)exec_register_enterprise_account:(NSString *)merchant_id
                            andstore_id:(NSString *)store_id
                            andjoinDict:(NSDictionary *)Dict
                                Success:(void (^)(NSDictionary *resDic))success
                             andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_xib_division/exec_register_enterprise_account" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
}
/**
 是否暂时关闭对公银行卡认证（注册企业客户）
 1表是：暂时关闭 0表否
 */
-(void)whether_to_temporarily_close_corporate_bank_card_certification:(NSString *)merchant_id
                                                          andstore_id:(NSString *)store_id
                                                              Success:(void (^)(NSDictionary *resDic))success
                                                           andfailure:(void (^)(void))failure{
    
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
   
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_xib_division/whether_to_temporarily_close_corporate_bank_card_certification" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}

#pragma mark - 订单退款确认（同意或拒绝）
/**
 订单退款确认（同意或拒绝）
 类型 1表同意退款 2表拒绝退款
 */
-(void)order_refund:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
          andorder_id:(NSString *)order_id
              andtype:(NSString *)type
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:order_id forKey:@"order_id"];
    [dic setValue:type forKey:@"type"];

    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/order_refund" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
/**
 商家退款 接口
 */
-(void)merchant_refund:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
           andjoinDict:(NSDictionary *)Dict
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    for (NSString *key in Dict) {
        //        NSLog(@"%@",key);
        
        [dic setValue:Dict[key] forKey:key];
    }
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/merchant_refund" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}
/**
 获取平台价计算公式中的费率 接口
 */
-(void)get_plat_price_rate:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_plat_price_rate" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

/**
 获取商品平台价 根据商品原价和优惠价计算平台价 接口
 */
-(void)get_plat_price_according_goods_price_and_discount_price:(NSString *)merchant_id
                                                   andstore_id:(NSString *)store_id
                                                andgoods_price:(NSString *)goods_price
                                             anddiscount_price:(NSString *)discount_price
                                                       Success:(void (^)(NSDictionary *resDic))success
                                                    andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:goods_price forKey:@"goods_price"];
    [dic setValue:discount_price forKey:@"discount_price"];
    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"merchant_center/get_plat_price_according_goods_price_and_discount_price" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
}

#pragma mark -  核销设置
/**
 获取店铺的核销设置 接口
 */
-(void)get_store_auto_confirm_info:(NSString *)merchant_id
                       andstore_id:(NSString *)store_id
                           Success:(void (^)(NSDictionary *resDic))success
                        andfailure:(void (^)(void))failure{
    
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];

    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/get_store_auto_confirm_info" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}

/**
 设置自动核销或手动核销 接口
 */
-(void)set_store_auto_confirm:(NSString *)merchant_id
                  andstore_id:(NSString *)store_id
              andauto_confirm:(NSString *)auto_confirm
                      Success:(void (^)(NSDictionary *resDic))success
                   andfailure:(void (^)(void))failure{
    //里层的parameter
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:merchant_id forKey:@"merchant_id"];
    [dic setValue:store_id forKey:@"store_id"];
    [dic setValue:auto_confirm forKey:@"auto_confirm"];

    
    UserModel *model = [UserModel getUseData];
    [dic setValue:model.token forKey:@"token"];
    
    NSString *timestamp = [FBHAppViewModel currentTimeStr];
    [dic setValue:timestamp forKey:@"timestamp"];
    NSString *process = [NSString stringWithFormat:@"%@%@",merchant_id,timestamp];
    [dic setValue:[MD5Sign MD5:process] forKey:@"process"];
    
    [YBHttpTool post:@"service_center/set_store_auto_confirm" params:dic success:^(NSDictionary *obj) {
        success(obj);
        
    } failure:^(NSError *error) {
        failure();
        
    }];
    
    
}
@end
