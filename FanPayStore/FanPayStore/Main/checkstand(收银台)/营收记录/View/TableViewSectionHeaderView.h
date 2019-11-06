//
//  TableViewSectionHeaderView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic ,strong) UILabel *label;
@property (nonatomic ,strong) UILabel *label1;
@property (nonatomic ,strong) NSString *titleStr;
@property (strong,nonatomic)NSDictionary * Data;
@end
