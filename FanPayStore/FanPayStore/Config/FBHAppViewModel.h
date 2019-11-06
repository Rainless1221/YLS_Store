//
//  FBHAppViewModel.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBHAppViewModel : NSObject

+(instancetype)shareViewModel;

/**
 获取服务器当前时间信息
 */
-(void)geTget_time_infoSuccess:(id (^)(NSDictionary *resDic))success
                    andfailure:(id (^)(void))failure;

/**
 应用验证接口
 */
-(void)geTcaptchaWithphone:(NSString *)phone
                   andtype:(NSString *)type
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 商家注册
 */
-(void)getRegisteruser:(NSString *)phone
               andcode:(NSString *)code
           andpassword:(NSString *)password
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure;

/**
 去登录（密码）
 */
-(void)userloginWithphone:(NSString *)phone
               andcaptcha:(NSString *)captcha
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure;
/**
 去登录(短信)
 */
-(void)userloginWithphone:(NSString *)phone
           andCodecaptcha:(NSString *)captcha
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure;
/**
 重置登录密码
 */
-(void)reset_login_password:(NSString *)phone
                    andcode:(NSString *)code
                andpassword:(NSString *)password
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;
/**
 设置或重置支付密码
 */
-(void)set_payment_password:(NSString *)merchant_id
                    andcode:(NSString *)code
                andpassword:(NSString *)password
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;
/**
 更改绑定手机号
 */
-(void)change_binded_mobile:(NSString *)merchant_id
                    andcode:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;

/**
 判断支付密码是否存在
 */
-(void)is_exist_pay_pwd:(NSString *)merchant_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;

/**
 验证支付密码是否正确
 */
-(void)verify_payment_password:(NSString *)merchant_id
                   andpassword:(NSString *)password
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;

/**
 设置或重置支付密码前 验证原支付密码或验证码
 */
-(void)verify_old_pwd_or_code_before_set_payment_password:(NSString *)merchant_id
                                                   andkey:(NSString *)key
                                                andsiring:(NSString *)siring
                                                  Success:(void (^)(NSDictionary *resDic))success
                                               andfailure:(void (^)(void))failure;
#pragma mark - 工作台
/**
 获取工作台上半部分信息 如当日收银、当日订单、当日预定、待办事项、累计访客、成功转化率等
 */
-(void)get_workbench_upper_part_info:(NSString *)merchant_id
                         andstore_id:(NSString *)store_id
                             Success:(void (^)(NSDictionary *resDic))success
                          andfailure:(void (^)(void))failure;
/**
 获取工作台信息 下半部分信息 如店铺订单统计、店铺访客统计
 */
-(void)get_workbench_lower_part_info:(NSString *)merchant_id
                         andstore_id:(NSString *)store_id
                      andsearch_date:(NSString *)search_date
                             Success:(void (^)(NSDictionary *resDic))success
                          andfailure:(void (^)(void))failure;
/**
 生成店铺二维码
 */
-(void)generate_store_qrcode:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;
/**
 获取到店消费码
 */
-(void)get_into_store_qrcode:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;
/**
 商户端扫描订单二维码后进行确认处理
 */
-(void)use_order_code:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
         andparameter:(NSString *)parameter
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;

/**
 商户确认订单：输入订单验证码
 */
-(void)input_order_code:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
          andorder_code:(NSString *)order_code
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;

/**
 设置店铺状态 接口
 */
-(void)set_store_status:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
          andstore_status:(NSString *)store_status
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;

/**
 获取桌码列表信息 接口
 */
-(void)list_table_number:(NSString *)merchant_id
                        andstore_id:(NSString *)store_id
                                Success:(void (^)(NSDictionary *resDic))success
                            andfailure:(void (^)(void))failure;
/**
 生成桌码 接口
 */
-(void)create_table_number_qrcode:(NSString *)merchant_id
                      andstore_id:(NSString *)store_id
                  andtable_number:(NSString *)table_number
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure;
/**
 删除桌码 接口
 */
-(void)delete_table_number:(NSString *)merchant_id
                      andstore_id:(NSString *)store_id
                  andt_n_id:(NSString *)t_n_id
                          Success:(void (^)(NSDictionary *resDic))success
                       andfailure:(void (^)(void))failure;
#pragma mark - 收银台
/**
 获取收银台基本信息
 */
-(void)get_checkstand_info:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 获取收银台收支及某天收支列表信息
 */
-(void)list_checkstand_consumption:(NSString *)merchant_id
                       andstore_id:(NSString *)store_id
                       andlistDict:(NSDictionary *)Dict
                           Success:(void (^)(NSDictionary *resDic))success
                        andfailure:(void (^)(void))failure;
/**
 提现页面信息
 */
-(void)get_withdrawal_info:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 提交提现申请
 */
-(void)insert_withdraw_info:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                andlistDict:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;
/**
 验证验证码 提交提现申请前 接口
 */
-(void)verify_code_before_insert_withdraw_info:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                andlistDict:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;
/**
 获取提现记录
 */
-(void)get_withdrawals_log:(NSString *)merchant_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;

/**
 获取 营收记录列表
 */
-(void)list_checkstand_revenue:(NSString *)merchant_id
                   andstore_id:(NSString *)store_id
                   andlistDict:(NSDictionary *)Dict
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;

/**
 获取某条营收记录详情
 */
-(void)get_checkstand_revenue:(NSString *)merchant_id
                  andstore_id:(NSString *)store_id
                  andlistDict:(NSDictionary *)Dict
                      Success:(void (^)(NSDictionary *resDic))success
                   andfailure:(void (^)(void))failure;

#pragma mark - 商家中心
/**
 登录成功后 获取商家中心的信息（商家中心显示的信息）
 */
-(void)list_business_center:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;

/**
 获取店铺ID
 */
-(void)get_store_id:(NSString *)merchant_id
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure;

/**
 获取店铺申请信息
 */
-(void)get_store_application_info:(NSString *)merchant_id
                          Success:(void (^)(NSDictionary *resDic))success
                       andfailure:(void (^)(void))failure;
/**
 获取店铺申请信息（已通过审核） 接口
 */
-(void)get_store_application_pass_info:(NSString *)merchant_id
                               Success:(void (^)(NSDictionary *resDic))success
                            andfailure:(void (^)(void))failure;
/**
 判断店铺名称是否已存在
 */
-(void)is_exist_store_name:(NSString *)merchant_id
             andstore_name:(NSString *)store_name
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;

/**
 是否提示：添加翻呗活动或优惠商品
 */
-(void)tips_for_merchant_about_discount_goods:(NSString *)merchant_id
                                  andstore_id:(NSString *)store_id
                                      Success:(void (^)(NSDictionary *resDic))success
                                   andfailure:(void (^)(void))failure;

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
                     andfailure:(void (^)(void))failure;
/**
 上传图片
 */
-(void)uploadPicturesOss:(NSString *)merchant_id
           andpicture:(NSString *)picture
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;


/**
 获取供选择的店铺类型数据
 */
-(void)get_store_category_info:(NSString *)merchant_id
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;
/**
 根据一级分类ID获取二级分类
 */
-(void)get_sec_store_category_info:(NSString *)merchant_id
                    andcategory_id:(NSString *)category_id
                           Success:(void (^)(NSDictionary *resDic))success
                        andfailure:(void (^)(void))failure;
/**
 获取商家账户信息
 */
-(void)get_merchant_info:(NSString *)merchant_id
             andstore_id:(NSString *)store_id
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure;
/**
 获取商户店铺粉丝信息 获取店铺的关注者的信息
 */
-(void)list_store_fans:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
               andpage:(NSString *)page
              andlimit:(NSString *)limit
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure;

/**
 获取间接粉丝信息、获取粉丝的粉丝信息 接口
 */
-(void)get_sec_class_fans_info:(NSString *)merchant_id
                    anduser_id:(NSString *)user_id
                   andstore_id:(NSString *)user_type
                       andpage:(NSString *)page
                      andlimit:(NSString *)limit
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;
/**
 发布商品
 */
-(void)insert_goods:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andGoodDict:(NSDictionary *)Dict
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure;

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
                andfailure:(void (^)(void))failure;
/**
 根据商品ID获取商品信息
 */
-(void)get_goods_info:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
          andgoods_id:(NSString *)goods_id
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;
/**
 上架或下架商品
 */
-(void)set_goods_sale_type:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               andgoods_id:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 删除商品（已下架的商品）
 */
-(void)delete_goods:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andgoods_id:(NSArray *)idArray
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure;
/**
 获取翻呗设置列表信息
 */
-(void)list_goods_discount:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               anddiscount:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 添加或编辑店铺翻呗活动、翻呗设置
 */
-(void)insert_update_store_discount:(NSString *)merchant_id
                        andstore_id:(NSString *)store_id
                        anddiscount:(NSDictionary *)Dict
                            Success:(void (^)(NSDictionary *resDic))success
                         andfailure:(void (^)(void))failure;

/**
 获删除翻呗活动
 */
-(void)delete_store_discount:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSString *)discount
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;

/**
 获取翻呗设置详情
 */
-(void)detail_goods_discount:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSDictionary *)Dict
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;
/**
 获取优惠商品列表信息
 */
-(void)list_store_discount_goods:(NSString *)merchant_id
                     andstore_id:(NSString *)store_id
                     anddiscount:(NSDictionary *)Dict
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure;
/**
 添加优惠商品
 */
-(void)insert_discount_goods:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSDictionary *)Dict
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;
/**
 删除优惠商品
 */
-(void)delete_discount_goods:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                 anddiscount:(NSDictionary *)Dict
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;
/**
 获取订单列表信息
 */
-(void)list_merchant_orders:(NSString *)merchant_id
                andstore_id:(NSString *)store_id
                  andorders:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;
/**
 获取订单详情
 */
-(void)detail_merchant_orders:(NSString *)merchant_id
                  andorder_id:(NSString *)order_id
                      Success:(void (^)(NSDictionary *resDic))success
                   andfailure:(void (^)(void))failure;

/**
 获取消息中心信息
 */
-(void)list_news:(NSString *)merchant_id
         Success:(void (^)(NSDictionary *resDic))success
      andfailure:(void (^)(void))failure;

/**
 获取某类型的消息列表
 */
-(void)list_news_info:(NSString *)merchant_id
              andDict:(NSDictionary *)Dict
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;

/**
 获取消息详情
 */
-(void)detail_news_info:(NSString *)merchant_id
             andnews_id:(NSString *)news_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;

/**
全部忽略：将未读的设为已读 接口
 */
-(void)set_news_read:(NSString *)merchant_id
                            andDict:(NSDictionary *)Dict
                            Success:(void (^)(NSDictionary *resDic))success
                        andfailure:(void (^)(void))failure;


/**
 编辑商品
 */
-(void)edit_goods:(NSString *)merchant_id
      andstore_id:(NSString *)store_id
          andgood:(NSDictionary *)Dict
          Success:(void (^)(NSDictionary *resDic))success
       andfailure:(void (^)(void))failure;


/**
 商家回复用户
 */
-(void)merchant_reply_order_evaluate:(NSString *)merchant_id
                         andstore_id:(NSString *)store_id
                         andorder_id:(NSString *)order_id
                          andcontent:(NSString *)content
                             Success:(void (^)(NSDictionary *resDic))success
                          andfailure:(void (^)(void))failure;

/**
 订单回复列表
 */
-(void)list_order_reply:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
            andorder_id:(NSString *)order_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;

/**
 删除订单 接口
 */
-(void)delete_order:(NSString *)merchant_id
        andstore_id:(NSString *)store_id
        andorder_id:(NSString *)order_id
            Success:(void (^)(NSDictionary *resDic))success
         andfailure:(void (^)(void))failure;

/**
 获取商品分类信息 接口
 */
-(void)list_goods_category:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;

/**
 添加商品分类 接口
 */
-(void)add_goods_category:(NSString *)merchant_id
              andstore_id:(NSString *)store_id
         andcategory_name:(NSString *)category_name
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure;

/**
 删除商品分类 接口
 */
-(void)delete_goods_category:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
              andcategory_id:(NSString *)category_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;
/**
 编辑商品分类 接口
 */
-(void)edit_goods_category:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
            andcategory_id:(NSString *)category_id
          andcategory_name:(NSString *)category_name
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 获取店铺温馨提示信息 接口
 */
-(void)get_store_tips:(NSString *)merchant_id
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;


/**
 获取分店信息接口
 */
-(void)get_branch_store_info:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
              andbranch_type:(NSString *)branch_type
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;



/**
 获取单个分店信息接口
 */
-(void)get_one_branch_store:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
           andbranch_mer_id:(NSString *)branch_mer_id
         andbranch_store_id:(NSString *)branch_store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;

/**
 添加分店 接口
 */
-(void)add_branch_store:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
            andbankDict:(NSDictionary *)Dict
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;

/**
 删除分店 接口
 */
-(void)delete_branch_store:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               andbankDict:(NSDictionary *)Dict
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;
/**
 切换分店时更新令牌信息（生成时间），防止切换后退出登录的情况发生 接口
 */
-(void)update_token_info_when_switch_store:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               andbankDict:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;

/**
 添加银盛子商户注册信息 接口
 */
-(void)add_ysepay_merchant_info:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
               andbankDict:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;

/**
 获取银盛子商户注册信息（未审核通过的） 接口
 */
-(void)get_ysepay_merchant_info:(NSString *)merchant_id
                    andstore_id:(NSString *)store_id
                        Success:(void (^)(NSDictionary *resDic))success
                     andfailure:(void (^)(void))failure;


/**
 获取提现账户信息完成情况 接口
 */
-(void)get_completion_ysepay_mer_info:(NSString *)merchant_id
                    andstore_id:(NSString *)store_id
                        Success:(void (^)(NSDictionary *resDic))success
                     andfailure:(void (^)(void))failure;

/**
 获取各银行信息 接口
 */
-(void)get_bank_info:(NSString *)merchant_id
         andstore_id:(NSString *)store_id
             Success:(void (^)(NSDictionary *resDic))success
          andfailure:(void (^)(void))failure;

/**
 获取省份城市信息 接口
 */
-(void)get_province_and_city:(NSString *)merchant_id
                 andstore_id:(NSString *)store_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;

/**
 获取支行信息：根据省份城市和所属银行 接口
 */
-(void)get_branch_bank:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
           andprovince:(NSString *)province
           andcity:(NSString *)city
           andbank_name:(NSString *)bank_name
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;

#pragma mark - 特惠活动
/**
 获取特惠活动列表信息 接口
 */
-(void)list_preferential_activities:(NSString *)merchant_id
                                 andstore_id:(NSString *)store_id
                                 andbankDict:(NSDictionary *)Dict
                                     Success:(void (^)(NSDictionary *resDic))success
                                  andfailure:(void (^)(void))failure;

/**
    添加或编辑店铺特惠活动 接口
 */
-(void)insert_update_preferential_activities:(NSString *)merchant_id
                                 andstore_id:(NSString *)store_id
                                 andbankDict:(NSDictionary *)Dict
                                     Success:(void (^)(NSDictionary *resDic))success
                                  andfailure:(void (^)(void))failure;

/**
 添加特惠商品 接口
 */
-(void)insert_preferential_goods:(NSString *)merchant_id
                                 andstore_id:(NSString *)store_id
                                 andbankDict:(NSDictionary *)Dict
                                     Success:(void (^)(NSDictionary *resDic))success
                                  andfailure:(void (^)(void))failure;
/**
删除特惠商品 接口
 */
-(void)delete_preferential_goods:(NSString *)merchant_id
                     andstore_id:(NSString *)store_id
                     andbankDict:(NSDictionary *)Dict
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure;


/**
获取特惠活动详情 接口
 */
-(void)get_preferential_detail:(NSString *)merchant_id
                     andstore_id:(NSString *)store_id
              andpreferential_id:(NSString *)preferential_id
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure;

/**
 删除特惠活动 接口
 */
-(void)delete_preferential_activity:(NSString *)merchant_id
                   andstore_id:(NSString *)store_id
            andpreferential_id:(NSString *)preferential_id
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;


#pragma mark - 标签
/**
为商品分类（标签）排序
 */
-(void)sort_goods_category:(NSString *)merchant_id
               andstore_id:(NSString *)store_id
          andcategory_sort:(NSDictionary *)array
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;


#pragma mark - 服务中心
/**
 根据银行卡号获取所属银行
 */
-(void)get_bank_name_by_card_num:(NSString *)merchant_id
                  andcard_number:(NSString *)card_number
                         Success:(void (^)(NSDictionary *resDic))success
                      andfailure:(void (^)(void))failure;
/**
 获取银行列表信息
 */
-(void)list_bank_info:(NSString *)merchant_id
              andpage:(NSString *)page
             andlimit:(NSString *)limit
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;

/**
 获取银行卡信息
 */
-(void)list_merchant_bank_card:(NSString *)merchant_id
                       andpage:(NSString *)page
                      andlimit:(NSString *)limit
                       Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;
/**
 添加银行卡
 */
-(void)insert_bank_card:(NSString *)merchant_id
            andbankDict:(NSDictionary *)Dict
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;
/**
 添加银行卡前的验证码验证 接口
 */
-(void)verify_code_before_insert_bank_card:(NSString *)merchant_id
                               andstore_id:(NSString *)store_id
            andbankDict:(NSDictionary *)Dict
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;

/**
 删除商户银行卡
 */
-(void)delete_bank_card:(NSString *)merchant_id
             andcard_id:(NSString *)card_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;
/**
 获取当前版本信息 商户端
 */
-(void)get_mer_version_info:(NSString *)merchant_id
                    Success:(void (^)(NSDictionary *resDic))success
                 andfailure:(void (^)(void))failure;
/**
 获取帮助与客服页面问题列表
 */
-(void)list_common_problem:(NSString *)merchant_id
                andproblem:(NSDictionary *)Dict
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;
/**
 获取帮助与客服页面问题详情
 */
-(void)detail_common_problem:(NSString *)merchant_id
               andproblem_id:(NSString *)problem_id
                     Success:(void (^)(NSDictionary *resDic))success
                  andfailure:(void (^)(void))failure;


/**
 提交加盟代理信息
 */
-(void)insert_join_agent:(NSString *)merchant_id
             andstore_id:(NSString *)store_id
             andjoinDict:(NSDictionary *)Dict
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure;

#pragma mark - 上传图片
-(void)uploadImageWithData:(UIImage *)image
                   andtype:(NSString *)type
                   Success:(void (^)(NSDictionary *resDic))success
                andfailure:(void (^)(void))failure;



#pragma mark ---------------------------------------- 一鹿省 ------------------------------
/**
    登录成功后 获取商家中心的信息（商家中心显示的信息） 接口
 */
-(void)yls_list_business_center:(NSString *)merchant_id
                               andstore_id:(NSString *)store_id
                 Success:(void (^)(NSDictionary *resDic))success
              andfailure:(void (^)(void))failure;

/**
 获取工作台基本信息 接口
 */
-(void)yls_get_workbench_info:(NSString *)merchant_id
                    andstore_id:(NSString *)store_id
                        Success:(void (^)(NSDictionary *resDic))success
                     andfailure:(void (^)(void))failure;

#pragma mark - 商家打印机终端
/**
商家打印机终端绑定 接口
 */
-(void)binding_pinter:(NSString *)merchant_id
                    andstore_id:(NSString *)store_id
                    andjoinDict:(NSDictionary *)Dict
                        Success:(void (^)(NSDictionary *resDic))success
                    andfailure:(void (^)(void))failure;
/**
获取商家打印机终端列表 接口
 */
-(void)pinter_list:(NSString *)merchant_id
          andstore_id:(NSString *)store_id
              Success:(void (^)(NSDictionary *resDic))success
           andfailure:(void (^)(void))failure;
/**
 商家打印机终端解绑 接口
 */
-(void)unbinding_pinter:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
          andprinter_id:(NSString *)printer_id
          andmachine_code:(NSString *)machine_code
           Success:(void (^)(NSDictionary *resDic))success
        andfailure:(void (^)(void))failure;
/**
开启/关闭 商家打印机 接口
 开关命令：1开启，2关闭
 */
-(void)shutdownRestart:(NSString *)merchant_id
       andstore_id:(NSString *)store_id
       andresponse_type:(NSString *)response_type
           Success:(void (^)(NSDictionary *resDic))success
        andfailure:(void (^)(void))failure;

/**
 商家打印机 进行打印 接口
 */
-(void)YlyReceipts:(NSString *)merchant_id
            andstore_id:(NSString *)store_id
          andorder_id:(NSString *)order_id
                Success:(void (^)(NSDictionary *resDic))success
             andfailure:(void (^)(void))failure;


#pragma mark - 分账认证
/**
 获取已有的银行卡资料 接口
 */
-(void)get_bank_card_info:(NSString *)merchant_id
              andstore_id:(NSString *)store_id
           Success:(void (^)(NSDictionary *resDic))success
        andfailure:(void (^)(void))failure;
/**
 获取分账认证银行卡信息 接口
 */
-(void)list_bank_card_info:(NSString *)merchant_id
              andstore_id:(NSString *)store_id
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure;
/**
 获取厦门国际银行 银行名称和行号信息 接口
 */
-(void)get_xib_bank_info:(NSString *)merchant_id
              andstore_id:(NSString *)store_id
                  Success:(void (^)(NSDictionary *resDic))success
               andfailure:(void (^)(void))failure;

/**
注册个人客户账户 接口
 */
-(void)exec_register_non_enterprise_account:(NSString *)merchant_id
                                andstore_id:(NSString *)store_id
                                andjoinDict:(NSDictionary *)Dict
                                    Success:(void (^)(NSDictionary *resDic))success
                                 andfailure:(void (^)(void))failure;


/**
 注册企业客户账户（对公银行卡） 接口
 */
-(void)exec_register_enterprise_account:(NSString *)merchant_id
                                andstore_id:(NSString *)store_id
                                andjoinDict:(NSDictionary *)Dict
                                    Success:(void (^)(NSDictionary *resDic))success
                                 andfailure:(void (^)(void))failure;

/**
 是否暂时关闭对公银行卡认证（注册企业客户）
 1表是：暂时关闭 0表否
 */
-(void)whether_to_temporarily_close_corporate_bank_card_certification:(NSString *)merchant_id
                            andstore_id:(NSString *)store_id
                                Success:(void (^)(NSDictionary *resDic))success
                             andfailure:(void (^)(void))failure;


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
          andfailure:(void (^)(void))failure;
/**
 商家退款 接口
 */
-(void)merchant_refund:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
           andjoinDict:(NSDictionary *)Dict
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure;
#pragma mark -  获取平台价计算公式中的费率
/**
 获取平台价计算公式中的费率 接口
 */
-(void)get_plat_price_rate:(NSString *)merchant_id
           andstore_id:(NSString *)store_id
               Success:(void (^)(NSDictionary *resDic))success
            andfailure:(void (^)(void))failure;
@end
