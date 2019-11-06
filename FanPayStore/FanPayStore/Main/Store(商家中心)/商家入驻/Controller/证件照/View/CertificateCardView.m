//
//  CertificateCardView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/17.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CertificateCardView.h"

@implementation CertificateCardView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    /** 标题 */
    UILabel *TextLabel  = [[UILabel alloc]init];
    TextLabel.text = @"证件图片";
    TextLabel.font = [UIFont systemFontOfSize:15];
    TextLabel.textColor = UIColorFromRGB(0x222222);
    [self addSubview:TextLabel];
    [TextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(10);
        make.right.mas_offset(-20);
        make.height.mas_offset(50);
    }];
    
    [self addSubview:self.line1];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(TextLabel.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    
    
    UILabel *cardLabel  = [[UILabel alloc]init];
    cardLabel.text = @"上传法人身份证照片";
    cardLabel.font = [UIFont systemFontOfSize:15];
    cardLabel.textColor = UIColorFromRGB(0x222222);
    [self addSubview:cardLabel];
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.line1.mas_bottom).offset(0);
        make.height.mas_offset(34);
    }];
    
    UILabel *cardTiLabel  = [[UILabel alloc]init];
    cardTiLabel.text = @"必须上传身份证正面、反面照片。";
    cardTiLabel.font = [UIFont systemFontOfSize:autoScaleW(15)];
    cardTiLabel.textColor = UIColorFromRGB(0xCCCCCC);
    [self addSubview:cardTiLabel];
    [cardTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(cardLabel.mas_bottom).offset(0);
        make.height.mas_offset(24);
    }];
    
    FL_Button *button1 = [FL_Button buttonWithType:UIButtonTypeCustom];
    //样式
    button1.status = FLAlignmentStatusCenter;
    button1.fl_padding = 2;button1.tag =1;
    [button1 addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self ButtonbutedTitle:button1];
    [self addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cardTiLabel.mas_right).offset(5);
        make.size.mas_offset(CGSizeMake(68, 40));
        make.centerY.equalTo(cardTiLabel.mas_centerY).offset(0);
    }];
    
    
    /**
     身份证图片
     **/
    [self addSubview:self.CardView1];
    [self.CardView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardTiLabel.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(140);
    }];

    [self addSubview:self.line2];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.CardView1.mas_bottom).offset(1);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    
    
    UILabel *cardLabel1  = [[UILabel alloc]init];
    cardLabel1.text = @"上传营业执照";
    cardLabel1.font = [UIFont systemFontOfSize:15];
    cardLabel1.textColor = UIColorFromRGB(0x222222);
    [self addSubview:cardLabel1];
    [cardLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.line2.mas_bottom).offset(0);
        make.height.mas_offset(34);
    }];
    UILabel *cardTiLabel1  = [[UILabel alloc]init];
    cardTiLabel1.text = @"上传营业执照正面照片。";
    cardTiLabel1.font = [UIFont systemFontOfSize:autoScaleW(15)];
    cardTiLabel1.textColor = UIColorFromRGB(0xCCCCCC);
    [self addSubview:cardTiLabel1];
    [cardTiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(cardLabel1.mas_bottom).offset(0);
        make.height.mas_offset(24);
    }];
    
    FL_Button *button2 = [FL_Button buttonWithType:UIButtonTypeCustom];
    //样式
    button2.status = FLAlignmentStatusCenter;
    button2.fl_padding = 2;button2.tag =2;
    [button2 addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [self ButtonbutedTitle:button2];
    [self addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cardTiLabel1.mas_right).offset(5);
        make.size.mas_offset(CGSizeMake(68, 40));
        make.centerY.equalTo(cardTiLabel1.mas_centerY).offset(0);
    }];
    
    
    
    
    
    /**
     营业执照图片
     **/
    [self addSubview:self.CardView2];
    [self.CardView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardTiLabel1.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(140);
    }];
    
    [self addSubview:self.line3];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.CardView2.mas_bottom).offset(1);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
    }];
    
    
    
    UILabel *cardLabel2  = [[UILabel alloc]init];
    cardLabel2.text = @"上传经营许可证";
    cardLabel2.font = [UIFont systemFontOfSize:15];
    cardLabel2.textColor = UIColorFromRGB(0x222222);
    [self addSubview:cardLabel2];
    [cardLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(self.line3.mas_bottom).offset(0);
        make.height.mas_offset(34);
    }];
    UILabel *cardTiLabel2  = [[UILabel alloc]init];
    cardTiLabel2.text = @"上传经营许可证书照片。";
    cardTiLabel2.font = [UIFont systemFontOfSize:autoScaleW(15)];
    cardTiLabel2.textColor = UIColorFromRGB(0xCCCCCC);
    [self addSubview:cardTiLabel2];
    [cardTiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(cardLabel2.mas_bottom).offset(0);
        make.height.mas_offset(24);
    }];
 
    FL_Button *button3 = [FL_Button buttonWithType:UIButtonTypeCustom];
    //样式
    button3.status = FLAlignmentStatusCenter;
    button3.fl_padding = 2;button3.tag =3;
    [button3 addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self ButtonbutedTitle:button3];
    [self addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cardTiLabel2.mas_right).offset(5);
        make.size.mas_offset(CGSizeMake(68, 40));
        make.centerY.equalTo(cardTiLabel2.mas_centerY).offset(0);
    }];
    
    
    
   
    
    
    
    
    /**
     经营许可证图片
     **/
    [self addSubview:self.CardView3];
    [self.CardView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardTiLabel2.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(140);
    }];
    
    
    
    
    /** 店铺环境图片列表1111 */
    UICollectionViewFlowLayout *flowLayout1=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,self.width,140) collectionViewLayout:flowLayout1];
    //设置代理
    self.collectionView1.delegate = self;
    self.collectionView1.dataSource = self;
    [self.CardView1 addSubview:self.collectionView1];
    self.collectionView1.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView1 registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    /** 店铺环境图片列表222 */
    UICollectionViewFlowLayout *flowLayout2=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout2 setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,self.width,140) collectionViewLayout:flowLayout2];
    //设置代理
    self.collectionView2.delegate = self;
    self.collectionView2.dataSource = self;
    [self.CardView2 addSubview:self.collectionView2];
    self.collectionView2.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView2 registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
    /** 店铺环境图片列表33333 */
    UICollectionViewFlowLayout *flowLayout3=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout3 setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView3 = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0,self.width,140) collectionViewLayout:flowLayout3];
    //设置代理
    self.collectionView3.delegate = self;
    self.collectionView3.dataSource = self;
    [self.CardView3 addSubview:self.collectionView3];
    self.collectionView3.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView3 registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.collectionView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    [self.collectionView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    [self.collectionView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.collectionView1) {
        [self collectionView:collectionView andArray:_UrlimageArr1];

        return _UrlimageArr1.count+1;

    }else if (collectionView == self.collectionView2){
        [self collectionView:collectionView andArray:_UrlimageArr2];

        return _UrlimageArr2.count+1;

    }else{
        [self collectionView:collectionView andArray:_UrlimageArr3];

        return _UrlimageArr3.count+1;

    }
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ZXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    if (collectionView == self.collectionView1) {
        if (indexPath.row == _UrlimageArr1.count) {
            cell.close.hidden = YES;
            cell.imgView.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
        }else if(_UrlimageArr1.count == 0){
            
        }else{

//            cell.imgView.image = [_imageArr1 objectAtIndex:indexPath.row];
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr1[indexPath.row]];
            url = [self isurl:url];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
            
        }
        
        
        cell.didSelectBlock = ^(NSInteger collviewInt) {
            NSIndexPath * indexPath1 = [self.collectionView1 indexPathForCell:cell];
            [self.UrlimageArr1 removeObjectAtIndex:indexPath1.row];
//            [_imageArr1 removeObjectAtIndex:indexPath1.row];
            [self.collectionView1 reloadData];
        };
        
    }else if (collectionView == self.collectionView2){
        if (indexPath.row == _UrlimageArr2.count) {
            cell.close.hidden = YES;
            cell.imgView.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
        }else if(_UrlimageArr2.count == 0){
            
        }else{
//            cell.imgView.image = [_imageArr2 objectAtIndex:indexPath.row];
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr2[indexPath.row]];
            url = [self isurl:url];

            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
            
        }
        
        
        
        cell.didSelectBlock = ^(NSInteger collviewInt) {
            NSIndexPath * indexPath1 = [self.collectionView2 indexPathForCell:cell];
            [self.UrlimageArr2 removeObjectAtIndex:indexPath1.row];
//            [_imageArr2 removeObjectAtIndex:indexPath1.row];
            [self.collectionView2 reloadData];
        };
        
    }else{
        if (indexPath.row == _UrlimageArr3.count) {
            cell.close.hidden = YES;
            cell.imgView.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
        }else if(_UrlimageArr3.count == 0){
            
        }else{
//            cell.imgView.image = [_imageArr3 objectAtIndex:indexPath.row];
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr3[indexPath.row]];
            url = [self isurl:url];

            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
            
        }
        
        
        
        
        
        cell.didSelectBlock = ^(NSInteger collviewInt) {
            NSIndexPath * indexPath1 = [self.collectionView3 indexPathForCell:cell];
            [self.UrlimageArr3 removeObjectAtIndex:indexPath1.row];
//            [_imageArr3 removeObjectAtIndex:indexPath1.row];
            [self.collectionView3 reloadData];
        };
    }
    
    //    cell.text.text = [NSString stringWithFormat:@"Cell %ld",indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((self.width-20)/3, (self.width-20)/3);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //        UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //        cell.backgroundColor = [UIColor redColor];
//        [self ImageArr:nil];
        NSLog(@"选择%ld",indexPath.row);
    NSInteger collview = [[NSIndexSet alloc]init];
    if (collectionView == self.collectionView1) {
        collview = 1;
    }else if (collectionView == self.collectionView2){
        collview = 2;
    }else{
        collview = 3;
    }
    
    if (self.didSelectBlock) {
        self.didSelectBlock(collview);
    }
    
}

#pragma mark - 判断链接
-(NSString *)isurl:(NSString *)image_pic{
    if ([PublicMethods isUrl:image_pic]) {
        
    }else{
        image_pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,image_pic];
    }
    return image_pic;
}

#pragma mark - 删除照片
-(void)moveImageBtnClick:(ZXCollectionCell *)aCell{

}

#pragma mark - 更新视图
-(void)collectionView:(UICollectionView *)collection andArray:(NSMutableArray *)arr{
    
    if (arr.count >=3) {
        if (collection == self.collectionView1) {
            [self.CardView1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(140*2);
            }];
        }else if (collection == self.collectionView2){
            [self.CardView2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(140*2);
            }];
        }
        else{
            [self.CardView3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(140*2);
            }];
        }
    }else{
        
        if (collection == self.collectionView1) {
            [self.CardView1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(140);
            }];
        }else if (collection == self.collectionView2){
            [self.CardView2 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(140);
            }];
        }
        else{
            [self.CardView3 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(140);
            }];
        }
        
    }
    
    
}
#pragma mark - 按钮富文本
-(void)ButtonbutedTitle:(UIButton *)sender{
    NSString * oneStr = @"示例图";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",oneStr]];
    //修改某个范围内的字体大小
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(7,2)];
    //修改某个范围内字的颜色
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x3D8AFF)  range:NSMakeRange(0,[str length])];
    //在某个范围内增加下划线
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [str length])];
    
    str.font = [UIFont systemFontOfSize:13];
    [sender setImage:[UIImage imageNamed:@"icn_message_hint"] forState:UIControlStateNormal];
    [sender setAttributedTitle:str forState:UIControlStateNormal];
}

#pragma mark - 示例图事件
-(void)BtnAction:(UIButton *)sender{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(sampleAction:)]) {
        [self.delagate sampleAction:sender.tag];
        
    }
}


#pragma mark - GET
-(UIView *)line1{
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    }
    return _line1;
}
-(UIView *)line2{
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    }
    return _line2;
}
-(UIView *)line3{
    if (!_line3) {
        _line3 = [[UIView alloc]init];
        _line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
    }
    return _line3;
}

-(UIView *)CardView1{
    if (!_CardView1) {
        _CardView1 = [[UIView alloc]init];
        _CardView1.backgroundColor = [UIColor yellowColor];
    }
    return _CardView1;
}
-(UIView *)CardView2{
    if (!_CardView2) {
        _CardView2 = [[UIView alloc]init];
        _CardView2.backgroundColor = [UIColor yellowColor];
    }
    return _CardView2;
}
-(UIView *)CardView3{
    if (!_CardView3) {
        _CardView3 = [[UIView alloc]init];
        _CardView3.backgroundColor = [UIColor yellowColor];
    }
    return _CardView3;
}

- (NSMutableArray *)UrlimageArr1{
    if (!_UrlimageArr1) {
        _UrlimageArr1 = [NSMutableArray array];
    }
    return _UrlimageArr1;
}
- (NSMutableArray *)UrlimageArr2{
    if (!_UrlimageArr2) {
        _UrlimageArr2 = [NSMutableArray array];
    }
    return _UrlimageArr2;
}
- (NSMutableArray *)UrlimageArr3{
    if (!_UrlimageArr3) {
        _UrlimageArr3 = [NSMutableArray array];
    }
    return _UrlimageArr3;
}
@end
