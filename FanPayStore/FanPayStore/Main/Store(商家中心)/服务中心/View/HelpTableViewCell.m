//
//  HelpTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "HelpTableViewCell.h"

@implementation HelpTableViewCell
-(void)setData:(NSDictionary *)Data{
    
    self.helpLabel.text = [NSString stringWithFormat:@"%@",Data[@"question"]];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
