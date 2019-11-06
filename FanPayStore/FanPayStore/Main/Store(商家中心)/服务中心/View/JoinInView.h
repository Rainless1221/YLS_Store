//
//  JoinInView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^joinBlock)(void);

@interface JoinInView : UIView
@property (nonatomic, copy) joinBlock joinblock;

@end
