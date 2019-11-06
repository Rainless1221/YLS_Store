//
//  StoreStatusView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreStatusView : UIView
@property (strong, nonatomic)  UIView       * View_Names;
@property (strong, nonatomic)  UIView       * View_Store;
@property (strong, nonatomic)  UIView       * View_Remin;
@property (strong, nonatomic)  UIView       * View_Image;
@property (strong, nonatomic)  UIView       * View_P;
/** */
@property (strong, nonatomic)  UIImageView  * store_logo;
@property (strong, nonatomic)  UILabel      * store_name;
@property (strong, nonatomic)  UILabel      * fans_number;
@property (strong, nonatomic)  UILabel      * goods_number;
@property (strong, nonatomic)  UILabel      * category_name;
@property (strong, nonatomic)  UIImageView  * category_icon;
/** */
@property (strong, nonatomic)    UILabel    * store_address;
@property (strong, nonatomic)    UILabel    * merchant_name;
@property (strong, nonatomic)    UILabel    * merchant_mobile;
@property (strong, nonatomic)    UILabel    * merchant_telephone;
@property (strong, nonatomic)    UILabel    * business_times;
@property (strong, nonatomic)    UILabel    * business_hours;

/***/
@property (strong, nonatomic)    UILabel        * reminder_String;
@property (strong, nonatomic)    NSMutableArray * reminder_Arr;
@property (strong, nonatomic)    UIView         * view_line4;
@property (strong, nonatomic)    UIView         * view_line7;
@property (strong, nonatomic)    UIView         * viewText_Remin;
@property (strong, nonatomic)    UIButton       * ReminButton;
/***/
@property (strong, nonatomic)    UIImageView    * door_face_pic;


/***/

@property (nonatomic, copy) void(^TheEditorBlock)(NSInteger tag);


/***/
@property (strong,nonatomic)NSMutableDictionary * StoreArray;
@end
