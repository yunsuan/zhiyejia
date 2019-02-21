//
//  LoginVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField *AccountTF;

@property (nonatomic, strong) UITextField *PassWordTF;

@property (nonatomic, strong) UIButton *RegisterBtn;

@property (nonatomic, strong) UIButton *QuickLoginBtn;

@property (nonatomic, strong) UIButton *LoginBtn;

@property (nonatomic, strong) UIButton *ProtocolBtn;

@property (nonatomic, strong) UIButton *FindPassWordBtn;

@property (nonatomic, strong) UIImageView *Headerimg;

@property (nonatomic, strong) UIButton  *QQBtn;

@property (nonatomic, strong) UIButton  *WEIBOBTN;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == _AccountTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
    if (textField == _PassWordTF) {
        if (textField.text.length > 20) {
            textField.text = [textField.text substringToIndex:20];
        }
    }
}

- (void)initUI{
    
    self.view.backgroundColor = CLWhiteColor;
    self.line.hidden = YES;
    
    _Headerimg = [[UIImageView alloc]initWithFrame:CGRectMake(148*SIZE, 39 *SIZE + NAVIGATION_BAR_HEIGHT, 63*SIZE, 54*SIZE)];
    _Headerimg.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:_Headerimg];
    
    _AccountTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, 219*SIZE, 314*SIZE, 15*SIZE)];
    _AccountTF.placeholder = @"请输入手机号";
    _AccountTF.keyboardType = UIKeyboardTypeNumberPad;
    _AccountTF.font = [UIFont systemFontOfSize:14*SIZE];
    [_AccountTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _AccountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_AccountTF];
//    _AccountTF.text = [UserModelArchiver unarchive].Account;
    
    _PassWordTF = [[UITextField alloc]initWithFrame:CGRectMake(22*SIZE, 266*SIZE, 314*SIZE, 15*SIZE)];
    _PassWordTF.placeholder = @"请输入密码";
    _PassWordTF.font = [UIFont systemFontOfSize:14*SIZE];
    [_PassWordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _PassWordTF.secureTextEntry = YES;
    [self.view addSubview:_PassWordTF];
//    _PassWord.text = [UserModelArchiver unarchive].Password;
    
    _LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _LoginBtn.frame = CGRectMake(22*SIZE, 367*SIZE, 316*SIZE, 41*SIZE);
    _LoginBtn.layer.masksToBounds = YES;
    _LoginBtn.layer.cornerRadius = 2*SIZE;
    _LoginBtn.backgroundColor = CLLoginBtnColor;
    [_LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _LoginBtn.titleLabel.font = [UIFont systemFontOfSize:16*SIZE];
    [_LoginBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_LoginBtn];
    
    
    _ProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _ProtocolBtn.frame =  CGRectMake(43*SIZE, 325*SIZE, 100*SIZE, 13*SIZE);
    [_ProtocolBtn setTitle:@"我已阅读并同意" forState: UIControlStateNormal];
    [_ProtocolBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    _ProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:12*SIZE];
    [_ProtocolBtn addTarget:self action:@selector(Protocol) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ProtocolBtn];
    
    
    _FindPassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _FindPassWordBtn.frame =  CGRectMake(283*SIZE, 417*SIZE, 60*SIZE, 15*SIZE);
    [_FindPassWordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_FindPassWordBtn setTitleColor:CLContentLabColor forState:UIControlStateNormal];
    _FindPassWordBtn.titleLabel.font = [UIFont systemFontOfSize:14*SIZE];
    [_FindPassWordBtn addTarget:self action:@selector(FindPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_FindPassWordBtn];
}


@end
