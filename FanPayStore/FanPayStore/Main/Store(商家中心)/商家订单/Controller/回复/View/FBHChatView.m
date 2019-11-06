//
//  FBHChatView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/25.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "FBHChatView.h"

@implementation FBHChatView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
    
        [self addSubview:self.list_HView];
        /* 用心地回复用户留言，有助于获得用户的 认可。 */
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15,11,ScreenW,12);
        label.numberOfLines = 0;
        label.textColor = UIColorFromRGB(0x999999);
        label.font = [UIFont systemFontOfSize:12];
        label.text = @"用心地回复用户留言，有助于获得用户的 认可。";
        [self.list_HView addSubview:label];
        
        
        /*本次订单得分*/
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(15,label.bottom+20,ScreenW,15);
        label1.numberOfLines = 0;
        label1.textColor = UIColorFromRGB(0x222222);
        label1.font = [UIFont systemFontOfSize:15];
        label1.text = @"本次订单得分";
        [self.list_HView addSubview:label1];
        
        //星星
        self.starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(15, label1.bottom+20, 120, 35)];
        self.starEvaluator.delegate = self;
        [self.list_HView addSubview:self.starEvaluator];
        //    self.starEvaluator = starEvaluator;
        [self.starEvaluator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.equalTo(label1.mas_bottom).offset(36);
            make.size.mas_offset(CGSizeMake(120, 35));
        }];
        self.starEvaluator.userInteractionEnabled = NO;
        self.starEvaluator.currentValue = 4;
        
        /** 分 */
        
        self.fen = [[UILabel alloc]init];
        self.fen.text = @"分";
        self.fen.textColor= UIColorFromRGB(0xF7AE2B);
        self.fen.font = [UIFont systemFontOfSize:15];
        [self.list_HView addSubview:self.fen];
        [self.fen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.top.equalTo(label1.mas_bottom).offset(36);
            make.height.mas_offset(30);
        }];
        
        
        /* 评论 */
        
        self.label_review = [[UILabel alloc] init];
        self.label_review.frame = CGRectMake(15,11,ScreenW-30,12);
        self.label_review.numberOfLines = 0;
        self.label_review.textColor = UIColorFromRGB(0x222222);
        self.label_review.backgroundColor = UIColorFromRGB(0xF6F6F6);
        self.label_review.layer.cornerRadius = 5;
        self.label_review.font = [UIFont systemFontOfSize:14];
//        self.label_review.text = @"环小清新，看着服干净，位置也容易找，中华城南区五楼电梯。他们家味还算比较道，如果喜欢口味重或者偏爱辣不建议了。";
        [self.list_HView addSubview:self.label_review];
        [self.label_review mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-15);
            make.left.mas_offset(15);
            make.top.equalTo(self.fen.mas_bottom).offset(35);
            make.bottom.mas_offset(-10);
        }];
        
        
        
        
//        self.ListData = [[NSMutableArray alloc]initWithObjects:@"我们非常在意餐点的品质，感谢您认真的评价，我们会再接再厉，欢迎您下次光",@"梨花香",@"缠着衣角掠过熙攘,复悄入红帘深帐,听枝头黄鹂逗趣儿",@"细风绕指淌,坐船舫,兰桨拨开雾霭迷茫,不觉已一日过半,过眼的葱郁风光,悉数泛了黄,褪尽温度的风,无言牵引中,便清晰了在此的眉目,暮色的消融,隐约了晦朔葱茏,在这老街回眸,烟云中追溯我是谁,只消暮雨点滴",@"便足以粉饰这是非,待这月色涌起,谁人轻叩这门扉",@"苔绿青石板街,斑驳了流水般岁月,小酌三盏两杯,理不清缠绕的情结,在你淡漠眉间,瞥见离人的喜悲霜雪", nil];
        [self addSubview:self.ChatList];
    
        [self.ChatList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_offset(0);
            make.bottom.mas_offset(-60);
            make.top.equalTo(self.list_HView.mas_bottom).offset(10);
        }];
        
        
        
        
        
    }
    
    return self;
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ListData.count;
//    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.Chat_label.text = [NSString stringWithFormat:@"%@",self.ListData[indexPath.row][@"reply_content"]];
    
    cell.Data = self.ListData[indexPath.row];
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *Header = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    Header.text = @"全部回复 ";
    Header.textColor = UIColorFromRGB(0x222222);
    Header.textAlignment = 1;
    Header.font = [UIFont systemFontOfSize:15];
    Header.backgroundColor = [UIColor whiteColor];
    return Header;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *footer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 52)];
    footer.text = @"还没有回复信息 ";
    footer.textColor = UIColorFromRGB(0x999999);
    footer.textAlignment = 1;
    footer.font = [UIFont systemFontOfSize:12];
    footer.backgroundColor = [UIColor whiteColor];
    
    if (self.ListData.count>0) {
        return nil;
    }else{
        return footer;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 52;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UILabel *materialNameLbe=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-10*2, 20)];
    materialNameLbe.textAlignment=NSTextAlignmentLeft;
    materialNameLbe.font=[UIFont systemFontOfSize:16];
    
    materialNameLbe.text = self.ListData[indexPath.row][@"reply_content"];
    
    materialNameLbe.numberOfLines=0;
    materialNameLbe.lineBreakMode=NSLineBreakByWordWrapping;
    CGSize size=[materialNameLbe sizeThatFits:CGSizeMake(materialNameLbe.frame.size.width, MAXFLOAT)];
    if (size.height>20) {
        materialNameLbe.frame=CGRectMake(10, 5, materialNameLbe.frame.size.width, size.height);
        heightCell=size.height+5*2;
        
        
    }else{
        materialNameLbe.frame=CGRectMake(10,5, materialNameLbe.frame.size.width, 20);
        
        heightCell=20+5*2;
        
    }
    

    
    return heightCell+30;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 52;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    //评论
    NSString *content = [NSString stringWithFormat:@"%@",Data[@"content"]];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[content dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//
//    self.label_review.attributedText = attributedString;
    self.label_review.text = content;
    
    
    NSString *score = [NSString stringWithFormat:@"%@",Data[@"score"]];
    self.starEvaluator.currentValue = [score integerValue];


    self.fen.text = [NSString stringWithFormat:@"%@分",score];
    
    
}

#pragma mark - 懒加载
-(UIView *)list_HView{
    if (!_list_HView) {
        _list_HView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, autoScaleW(246))];
        _list_HView.backgroundColor = [UIColor whiteColor];
    }
    return _list_HView;
}
-(UITableView *)ChatList{
    if (!_ChatList) {
        _ChatList = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44) style:UITableViewStyleGrouped];
        [_ChatList registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"ChatTableViewCell"];
        _ChatList.delegate =  self;
        _ChatList.dataSource = self;
        _ChatList.backgroundColor = [UIColor clearColor];
        _ChatList.separatorStyle=UITableViewCellSeparatorStyleNone;//取消系统的分割线
        _ChatList.defaultNoDataText = @"";
        _ChatList.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
        _ChatList.backgroundView = [UIView new];
    }
    return _ChatList;
}
-(NSMutableArray *)ListData{
    if (!_ListData) {
        _ListData = [NSMutableArray array];
    }
    return _ListData;
}
@end
