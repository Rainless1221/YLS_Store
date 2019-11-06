//
//  NewVTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "NewVTableViewCell.h"

@implementation NewVTableViewCell
- (void)setData:(NSDictionary *)Data{
    
    self.add_time.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    /*标题*/
    self.news_title.text = [NSString stringWithFormat:@"%@",Data[@"news_title"]];
    /*内容*/
    self.news_content.text = [NSString stringWithFormat:@"%@",Data[@"news_content"]];
//    /**图片*/
//    NSString *url = [NSString stringWithFormat:@"%@",Data[@"news_pic"]];
//    [self.news_pic setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
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
