//
//  FBHFBSPViewController.h
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"
@protocol productDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)product:(NSArray *)productArr andindexPaths:(NSArray *)indexPath;
@end
@interface FBHFBSPViewController : BaseViewController
@property (strong,nonatomic)NSArray * indexPatharray;
@property (strong,nonatomic)NSString * discount_id;
@property(nonatomic,weak)id<productDelegate>delagate;
@end
