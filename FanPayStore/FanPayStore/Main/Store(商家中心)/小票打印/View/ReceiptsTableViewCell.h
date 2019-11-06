//
//  ReceiptsTableViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptsTableViewCell : UITableViewCell
@property (strong,nonatomic)UILabel * ReceName;
@property (strong,nonatomic)UILabel * ReceType;
@property (strong,nonatomic)UIButton * TypeButton;
@property (strong,nonatomic)UIButton * TypeButton_sele;
@property (strong,nonatomic)CBPeripheral * receData;
@end

NS_ASSUME_NONNULL_END
