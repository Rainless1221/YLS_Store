//
//  ChatTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/25.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.M_label];
        [self.M_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_offset(10);
            make.size.mas_offset(CGSizeMake(75, 15));
        }];
        
        [self addSubview:self.Time_label];
        [self.Time_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.M_label.mas_right).offset(5);
            make.top.mas_offset(10);
            
        }];
        
        [self addSubview:self.Chat_label];
        [self.Chat_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.top.equalTo(self.M_label.mas_bottom).offset(5);
            make.bottom.mas_offset(0);
            
        }];
    }
    return self;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    
    NSString *type = [NSString stringWithFormat:@"%@",Data[@"answer_type"]];
    if ([type isEqualToString:@"1"]) {
        _M_label.text = @"我的回复";
        _M_label.textColor = UIColorFromRGB(0xF7AE2B);

    }else{
        _M_label.text = @"客户回复";
        _M_label.textColor = UIColorFromRGB(0x222222);

    }
    
    _Time_label.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];

    
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@",Data[@"reply_content"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//
//    _Chat_label.attributedText = attributedString;
    _Chat_label.text = [NSString stringWithFormat:@"%@",Data[@"reply_content"]];

}
#pragma mark - 懒加载
-(UILabel *)M_label{
    if (!_M_label) {
        _M_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, 15)];
        _M_label.textColor = UIColorFromRGB(0xF7AE2B);
        _M_label.font = [UIFont systemFontOfSize:16];
        _M_label.text = @"我的回复";
    }
    return _M_label;
}
-(UILabel *)Time_label{
    if (!_Time_label) {
        _Time_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, 15)];
        _Time_label.textColor = UIColorFromRGB(0x999999);
        _Time_label.font = [UIFont systemFontOfSize:14];
        _Time_label.text = @"12-13 14:34";
    }
    return _Time_label;
}
-(UILabel *)Chat_label{
    if (!_Chat_label) {
        _Chat_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 65, 15)];
        _Chat_label.textColor = UIColorFromRGB(0x222222);
        _Chat_label.font = [UIFont systemFontOfSize:14];
        _Chat_label.numberOfLines = 0;
    }
    return _Chat_label;
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
