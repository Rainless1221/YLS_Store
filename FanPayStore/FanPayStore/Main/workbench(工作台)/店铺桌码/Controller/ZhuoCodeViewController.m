//
//  ZhuoCodeViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/13.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ZhuoCodeViewController.h"
#import "CodeTableViewCell.h"
#import "AddZhuoCodeController.h"

@interface ZhuoCodeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * CodeTabelview;
@property (strong,nonatomic)NSMutableArray * Data;
/*桌面二维码二次查看*/
@property (strong,nonatomic)UIView * codeView;
/*示例图 >>*/
@property (strong,nonatomic)UIView * shiliView;


@property (strong,nonatomic)UIView * imageView;
@property (strong,nonatomic)UIImageView * cellImage;
@property (strong,nonatomic)UILabel * zhuohao;

@end

@implementation ZhuoCodeViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺桌码";
    [self list_table_number];

    [self setupNav];
    /**
     *  UI
     */
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"table_number" object:nil];
    
}

- (void)conversionAction: (NSNotification *) notification {
    
    [self list_table_number];
    
}

-(void)list_table_number{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]list_table_number:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
            NSDictionary *DIC=resDic[@"data"];
            
            [self.Data removeAllObjects];
            
            for (NSDictionary *dict in DIC[@"table_number_info"]) {
                [self.Data addObject:dict];
            }
            [self.CodeTabelview reloadData];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}
#pragma mark - 导航栏
-(void)setupNav{

    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 28)];
    [leftbutton setTitle:@"清空" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem = rightitem;
    
}
-(void)RighAction{
    [self DeleViewAction];
}
#pragma mark - UI
-(void)createUI{
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,15,ScreenW-30,107);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];

    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,15,250,13.5);
    label.numberOfLines = 0;
    label.text= @"桌面编号二维码";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    [view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(10,label.bottom+10,view.width-20,32.5);
    label1.numberOfLines = 0;
    label1.text= @"用户通过生成的桌面编号二维码，可以快速进入APP或者小程序的店铺详情，进行下单。";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [view addSubview:label1];
    
    
    UILabel *label11 = [[UILabel alloc] init];
    label11.frame = CGRectMake(10,label1.bottom,view.width-20,32.5);
    label11.numberOfLines = 0;
    label11.text= @"示例图 >>";
    label11.font = [UIFont systemFontOfSize:13];
    label11.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    [view addSubview:label11];
    label11.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    
    [label11 addGestureRecognizer:labelTapGestureRecognizer];
    
    
    
    
    
    [self.view addSubview:self.CodeTabelview];
    [self.CodeTabelview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(160);
        make.left.right.bottom.mas_offset(0);
    }];
#pragma mark - /*桌面二维码*/
    UIView *TCview = [[UIView alloc] init];
    TCview.frame = CGRectMake(0,0,ScreenW-30,410);
    TCview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    TCview.layer.cornerRadius = 6;
    [self.codeView addSubview:TCview];
    [TCview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 410));
    }];
    /**
     叉号
     */
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(Buttonaction) forControlEvents:UIControlEventTouchUpInside];
    [TCview addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(5);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    /**
     横线
     */
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [TCview addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    
    /**
     标题
     */
    UILabel *Sampletext = [[UILabel alloc]init];
    Sampletext.text = @"桌面二维码";
    Sampletext.textAlignment = 1;
    Sampletext.textColor = UIColorFromRGB(0x222222);
    Sampletext.font = [UIFont systemFontOfSize:15];
    [TCview addSubview:Sampletext];
    [Sampletext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_offset(0);
        make.height.mas_offset(50);
    }];
    /**
     保存按钮
     */
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame = CGRectMake(0, 0, TCview.width-60, 44);
    //    queButton.backgroundColor = UIColorFromRGB(0x3D8AFF);
    //    queButton.layer.cornerRadius = 10;
    
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = queButton.bounds;
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [queButton.layer addSublayer:gl];
//
//    queButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    queButton.layer.shadowOffset = CGSizeMake(0,4);
//    queButton.layer.shadowOpacity = 1;
//    queButton.layer.shadowRadius = 9;
    
    [queButton setTitle:@"保存" forState:UIControlStateNormal];
    [queButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    queButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [queButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(queButtonaction) forControlEvents:UIControlEventTouchUpInside];
    queButton.layer.cornerRadius = 10;
    [TCview addSubview:queButton];
    [queButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(44);
    }];
    
    
    /*中间图片*/

    [TCview addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(-15);
        make.size.mas_offset(CGSizeMake(240, 247));
    }];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TCview.width, TCview.height)];
    image.image = [UIImage imageNamed:@"table_code_bg_type_02"];
    [self.imageView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(0);
        make.size.mas_offset(CGSizeMake(240, 247));
    }];
    UILabel *image_label = [[UILabel alloc] init];
    image_label.frame = CGRectMake(12,4,150,11.5);
    image_label.numberOfLines = 0;
    image_label.text = @"一鹿省APP";
    image_label.textColor = [UIColor colorWithRed:185/255.0 green:225/255.0 blue:253/255.0 alpha:1.0];
    image_label.font = [UIFont systemFontOfSize:12];
//    [self.imageView addSubview:image_label];
    
    
    UILabel *image_label1 = [[UILabel alloc] init];
    image_label1.frame = CGRectMake(13,20,150,11.5);
    image_label1.numberOfLines = 0;
    image_label1.text = @"技术支持";
    image_label1.textColor = [UIColor colorWithRed:120/255.0 green:201/255.0 blue:252/255.0 alpha:1.0];
    image_label1.font = [UIFont systemFontOfSize:8];
//    [self.imageView addSubview:image_label1];
    
    UILabel *image_label11 = [[UILabel alloc] init];
    image_label11.frame = CGRectMake(0,185,240,11.5);
    image_label11.numberOfLines = 0;
    image_label11.textAlignment =1;
    image_label11.text = @"扫描二维码，小程序或APP下单";
    image_label11.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    image_label11.font = [UIFont systemFontOfSize:12];
//    [self.imageView addSubview:image_label11];
    
    [self.imageView addSubview:self.cellImage];
    [self.cellImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(3);
        make.size.mas_offset(CGSizeMake(90, 90));
    }];
    [self.imageView addSubview:self.zhuohao];
    [self.zhuohao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-38);
        make.left.right.mas_offset(0);
        make.height.mas_offset(38);
    }];
    
#pragma mark - /*桌面二维码-示例图*/
    UIView *SLview = [[UIView alloc] init];
    SLview.frame = CGRectMake(0,0,ScreenW-30,368);
    SLview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    SLview.layer.cornerRadius = 6;
    [self.shiliView addSubview:SLview];
    [SLview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 368));
    }];
    /**
     叉号
     */
    UIButton *Button_sl = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button_sl setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [Button_sl addTarget:self action:@selector(Buttonaction) forControlEvents:UIControlEventTouchUpInside];
    [SLview addSubview:Button_sl];
    [Button_sl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(5);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    /**
     横线
     */
    UIView *line_sl = [[UIView alloc]init];
    line_sl.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [SLview addSubview:line_sl];
    [line_sl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    
    /**
     标题
     */
    UILabel *Sampletext_sl = [[UILabel alloc]init];
    Sampletext_sl.text = @"桌面二维码-示例图";
    Sampletext_sl.textAlignment = 1;
    Sampletext_sl.textColor = UIColorFromRGB(0x222222);
    Sampletext_sl.font = [UIFont systemFontOfSize:15];
    [SLview addSubview:Sampletext_sl];
    [Sampletext_sl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_offset(0);
        make.height.mas_offset(50);
    }];
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(50,73,SLview.width-100,180);
    imageView1.image = [UIImage imageNamed:@"桌码应用场景示例图"];
    imageView1.layer.borderWidth = 2;
    imageView1.layer.borderColor = [UIColor whiteColor].CGColor;
    [SLview addSubview:imageView1];

    /**
     确定按钮
     */
    UIButton *queButton_sl = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton_sl.frame = CGRectMake(0, 0, SLview.width-60, 44);
    //    queButton.backgroundColor = UIColorFromRGB(0x3D8AFF);
    //    queButton.layer.cornerRadius = 10;
    
//    CAGradientLayer *gl_sl = [CAGradientLayer layer];
//    gl_sl.frame = queButton_sl.bounds;
//    gl_sl.startPoint = CGPointMake(0, 0);
//    gl_sl.endPoint = CGPointMake(1, 1);
//    gl_sl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl_sl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl_sl.cornerRadius = 10;
//    [queButton_sl.layer addSublayer:gl_sl];
//
//    queButton_sl.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    queButton_sl.layer.shadowOffset = CGSizeMake(0,4);
//    queButton_sl.layer.shadowOpacity = 1;
//    queButton_sl.layer.shadowRadius = 9;
    
    [queButton_sl setTitle:@"确定" forState:UIControlStateNormal];
    [queButton_sl.titleLabel setFont:[UIFont systemFontOfSize:18]];
    queButton_sl.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [queButton_sl setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [queButton_sl addTarget:self action:@selector(queButtonaction) forControlEvents:UIControlEventTouchUpInside];
    queButton_sl.layer.cornerRadius = 10;
    [SLview addSubview:queButton_sl];
    [queButton_sl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(44);
    }];
}
#pragma mark - 叉号
-(void)Buttonaction{
    [self.codeView removeFromSuperview];
    [self.shiliView removeFromSuperview];

}
#pragma mark - 保存
-(void)queButtonaction{
    [self.codeView removeFromSuperview];
    [self.shiliView removeFromSuperview];
    
    UIImage *newImage = [[UIImage alloc]init];
    newImage = [self convertViewToImage:self.imageView];
    
    [self loadImageFinished:newImage];
    
}
-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)loadImageFinished:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
}
#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        
        msg = @"保存图片失败" ;
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
        
        msg = @"保存图片成功" ;
    }
}

-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    
//    UILabel *label= (UILabel*)recognizer.view;
//    NSLog(@"%@被点击了",label.text);
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.shiliView];
    
}
#pragma mark - 删除
-(void)DeleViewAction{
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"清空桌面二维码";
    [samView.deleteButton setTitle:@"确定" forState:UIControlStateNormal];
    NSString *card_number = [NSString stringWithFormat:@"确定要将清空店铺所有桌面二维码吗？"];
    samView.deleteText.text = card_number;
    
    NSString *ArrayString = [NSString new];

    for (int i = 1; i<=self.Data.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",self.Data[i-1][@"tn_id"]];
        if (i == self.Data.count) {
            ArrayString = [ArrayString stringByAppendingFormat:@"%@",urlstring];
        }else{
            ArrayString = [ArrayString stringByAppendingFormat:@"%@,",urlstring];
        }
        
    }
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];


        [[FBHAppViewModel shareViewModel]delete_table_number:model.merchant_id andstore_id:model.store_id andt_n_id:ArrayString Success:^(NSDictionary *resDic) {


            if ([resDic[@"status"] integerValue]==1) {
                //                NSDictionary *DIC = resDic[@"data"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"table_number" object:nil];

            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];

        }];
        
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
}
-(void)CellDeleViewAction:(NSString *)String{
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除桌面二维码";
    NSString *card_number = [NSString stringWithFormat:@"确定要删除该桌面二维码吗？"];
    samView.deleteText.text = card_number;
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        
        [[FBHAppViewModel shareViewModel]delete_table_number:model.merchant_id andstore_id:model.store_id andt_n_id:String Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue]==1) {
                //                NSDictionary *DIC = resDic[@"data"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"table_number" object:nil];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];

        }];
        
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];

}
#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Data.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CodeTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    if (indexPath.row==self.Data.count) {
        cell.addCodeBlock = ^{
            [self.navigationController pushViewController:[AddZhuoCodeController new] animated:NO];
        };
        cell.addButton.hidden = NO;

    }else{
        cell.Data = self.Data[indexPath.row];
        cell.addButton.hidden = YES;
        cell.deleCodeBlock = ^{
            NSString *str=[NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"tn_id"]];
            [self CellDeleViewAction:str];
        };
        
        cell.BaseCodeBlock  = ^{
            NSString *url = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"table_number_qrcode"]];
            [self.cellImage sd_setImageWithURL:[NSURL URLWithString:url]];
            
            self.zhuohao.text = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"table_number"]];
            [[UIApplication sharedApplication].keyWindow addSubview:self.codeView];
        };
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 180)];
    
    return footer;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  

    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"table_number" object:nil];
    
}
#pragma mark - 懒加载
-(UITableView *)CodeTabelview{
    if (!_CodeTabelview) {
        _CodeTabelview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _CodeTabelview.delegate = self;
        _CodeTabelview.dataSource = self;
        _CodeTabelview.backgroundColor = UIColorFromRGB(0xF6F6F6);
        
        [_CodeTabelview registerClass:[CodeTableViewCell class] forCellReuseIdentifier:@"CodeTableViewCell"];
        _CodeTabelview.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return _CodeTabelview;
}
-(UIView *)codeView{
    if (!_codeView) {
        _codeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _codeView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];

    }
    return _codeView;
}
-(UIView *)imageView{
    if (!_imageView) {
        _imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 240)];
        _imageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _imageView.layer.cornerRadius = 6;
    }
    return _imageView;
}
-(UIView *)shiliView{
    if (!_shiliView) {
        _shiliView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _shiliView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];
        
    }
    return _shiliView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(UIImageView *)cellImage{
    if (!_cellImage) {
        _cellImage = [[UIImageView alloc]init];
        _cellImage.layer.borderColor = UIColorFromRGB(0xCDCDCD).CGColor;
        _cellImage.layer.borderWidth = 1;
        _cellImage.layer.cornerRadius = 5;
    }
    return _cellImage;
}
-(UILabel *)zhuohao{
    if (!_zhuohao) {
        _zhuohao = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, ScreenW-30, 35)];
        _zhuohao.font = [UIFont systemFontOfSize:IPHONEWIDTH(21)];
        _zhuohao.textAlignment = 1;
        _zhuohao.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _zhuohao;
}
@end
