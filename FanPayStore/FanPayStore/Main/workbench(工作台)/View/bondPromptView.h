//
//  bondPromptView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bondPromptView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *promptImage;
@property (weak, nonatomic) IBOutlet UILabel *proptLabel;
@property (weak, nonatomic) IBOutlet UILabel *promptText;
/** 验证成功 **/
@property (nonatomic, copy) void(^bondBlock)(void);

@end
