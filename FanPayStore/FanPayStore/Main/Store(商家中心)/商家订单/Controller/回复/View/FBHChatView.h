//
//  FBHChatView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/25.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBHChatView : UIView <StarEvaluatorDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat heightCell;

}
@property (strong,nonatomic)UIView * list_HView;
@property (strong,nonatomic)StarEvaluator *starEvaluator;
@property (strong,nonatomic)UILabel * label_review;
@property (strong,nonatomic)UILabel *fen ;
/*列表*/
@property (strong,nonatomic)UITableView * ChatList;

@property (strong,nonatomic)NSDictionary * Data;
@property (strong,nonatomic)NSMutableArray * ListData;

@end

NS_ASSUME_NONNULL_END
