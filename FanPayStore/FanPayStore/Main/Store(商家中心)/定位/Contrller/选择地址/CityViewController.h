//
//  CityViewController.h
//  app
//
//  Created by 苹果笔记本 on 2019/4/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol cityDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)MapCitys:(NSString *)city;
@end

@interface CityViewController : UIViewController
@property(nonatomic,weak)id<cityDelegate>delagate;

@end
