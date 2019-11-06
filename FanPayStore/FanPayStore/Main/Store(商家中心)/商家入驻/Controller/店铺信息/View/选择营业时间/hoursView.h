//
//  hoursView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hoursView : UIView
@property (nonatomic, copy) void(^HoursBlock)(NSString *HoursString);

@end
