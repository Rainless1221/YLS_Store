//
//  FBHevaluateViewController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHevaluateViewController.h"

@interface FBHevaluateViewController ()<StarEvaluatorDelegate,UITextViewDelegate>
@property (strong,nonatomic)UIView *hevaView ;
@property (strong,nonatomic) FBHChatView *baseView;
@property (strong,nonatomic)UITextView *textView;
@end

@implementation FBHevaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"回复用户";
    [self merchant_center];
    [self createUI];
}
-(void)merchant_center{
    
    //list_order_reply
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];

    
    [[FBHAppViewModel shareViewModel]list_order_reply:model.merchant_id andstore_id:model.store_id andorder_id:self.order_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];

            
            self.baseView.Data = DIC[@"evaluate_info"];
            [self.baseView.ListData removeAllObjects];
            for (NSDictionary *dict in DIC[@"reply_info"]) {
                [self.baseView.ListData addObject:dict];
            }
            
            [self.baseView.ChatList reloadData];
            
            
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{

        [MBProgressHUD hideHUD];
    } ];
    
}
#pragma mark - UI
-(void)createUI{
    self.baseView = [[FBHChatView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.baseView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.baseView];
    
    
    
    /**
     * 评论输入
     */
    
    self.hevaView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH -(kIs_iPhoneX? 137:113), ScreenW, 49)];
    self.hevaView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.hevaView];
    //    [hevaView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.mas_offset(0);
    //        make.bottom.mas_offset(kIs_iPhoneX ? -25:0);
    //        make.height.mas_offset(49);
    //    }];
    
    self.textView = [[UITextView alloc]init];
    self.textView.delegate = self;
    self.textView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    [self.hevaView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(8);
        make.left.mas_offset(15);
        make.right.mas_offset(-88);
        make.bottom.mas_offset(-8);
    }];
    
    
    /** 表情 */
    UIButton *Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button1 setImage:[UIImage imageNamed:@"btn_dialogue_details_bottom_emoji"] forState:UIControlStateNormal];
    [self.hevaView addSubview:Button1];
    //    Button1.frame =CGRectMake(Button.left+5, 0, 24, 49);
    [Button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.equalTo(self.textView.mas_right).offset(5);
        make.width.mas_offset(24);
    }];
    
    /** 发送 */
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setImage:[UIImage imageNamed:@"btn_dialogue_details_bottom_send_normal"] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.hevaView addSubview:Button];
    //    Button.frame =CGRectMake(textView.left+5, 0, 24, 49);
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_offset(0);
        make.left.equalTo(Button1.mas_right).offset(10);
        make.width.mas_offset(24);
    }];
    
    
}
- (void)loadView
{
    [super loadView];
    self.view = [[UIScrollView alloc] initWithFrame:self.view.bounds];
}


- (void)viewWillAppear:(BOOL)animated
{
    //注册通知,监听键盘出现
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidShow:)
                                                name:UIKeyboardDidShowNotification
                                              object:nil];
    //注册通知，监听键盘消失事件
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleKeyboardDidHidden)
                                                name:UIKeyboardDidHideNotification
                                              object:nil];
    [super viewWillAppear:YES];
}

//监听事件
- (void)handleKeyboardDidShow:(NSNotification*)paramNotification
{
    //获取键盘高度
    NSValue *keyboardRectAsObject=[[paramNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect;
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.hevaView.centerY = self.view.height-(kIs_iPhoneX? keyboardRect.size.height+25:keyboardRect.size.height+25);
}

- (void)handleKeyboardDidHidden
{
    self.hevaView.centerY = ScreenH -(kIs_iPhoneX? 150-STATUS_BAR_HEIGHT:110-STATUS_BAR_HEIGHT);
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    
}

#pragma mark - 回复
-(void)ButtonAction{
    
    
    if (self.textView.text == nil || self.textView.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    

    [[FBHAppViewModel shareViewModel]merchant_reply_order_evaluate:model.merchant_id  andstore_id:model.store_id andorder_id:self.order_id andcontent:self.textView.text Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
//            NSDictionary *DIC = resDic[@"data"];
            
            [self merchant_center];

            self.textView.text = @"";
            [self.view endEditing:YES];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
    
}
#pragma mark - GET


@end
