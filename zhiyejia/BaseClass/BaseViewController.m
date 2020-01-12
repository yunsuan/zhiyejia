//
//  BaseViewController.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "LoginVC.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 13.0, *)) {
        
        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    } else {
        // Fallback on earlier versions
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialBaseViewInterface];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    if (@available(iOS 13.0, *)) {
        
        return UIStatusBarStyleDarkContent;
    } else {
        // Fallback on earlier versions
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - init
- (void)initialBaseViewInterface {
    
    self.view.backgroundColor = CLBackColor;
    [self.view addSubview:self.navBackgroundView];
    
    [self.navBackgroundView addSubview:self.titleLabel];
    [self.navBackgroundView addSubview:self.leftButton];
    [self.navBackgroundView addSubview:self.rightBtn];
}

- (void)ActionMaskBtn:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//提示框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1{
    UIAlertController *alert_forbidden = [UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    [alert_forbidden addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert_forbidden animated:YES completion:nil];
}

- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithDefaultBlack:(void(^)(void))defaultBlack{
    
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultBlack();
    }];
    [alert addAction:alert2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

//弹出框
- (void)alertControllerWithNsstring:(NSString *)str And:(NSString *)str1 WithCancelBlack:(void(^)(void))CancelBlack WithDefaultBlack:(void(^)(void))defaultBlack{
    UIAlertController *alert =[UIAlertController alertControllerWithTitle:str message:str1 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelBlack();
    }];
    UIAlertAction *alert2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        defaultBlack();
    }];
    [alert addAction:alert1];
    [alert addAction:alert2];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


/**
 *  检查输入的手机号正确与否
 */
- (BOOL)checkTel:(NSString *)str {
    
    NSString *regex = @"^((13[0-9])|(17[0-9])|(14[0-9])|(15[0-9])|(18[0-9])|(19[0-9])|16[0-9])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}

- (void)showContent:(NSString *)str {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.7f];
    hud.label.text= str;
    hud.label.textColor = [UIColor whiteColor];
    hud.margin = 10.f;
    [hud setOffset:CGPointMake(0, 10.f*SIZE)];
    //    hud.yOffset = 10.f * SIZE;
    hud.removeFromSuperViewOnHide = YES;
    //    [hud hide:YES afterDelay:1.5];
    [hud hideAnimated:YES afterDelay:1.5];
}

//判断字符串为空
- (BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

- (void)GotoLogin{
    
    LoginVC *nextVC = [[LoginVC alloc] init];
    nextVC.loginVCBlock = ^{
        
        [BaseRequest GET:PersonalGetAgentInfo_URL parameters:@{} success:^(id  _Nonnull resposeObject) {
            
            if ([resposeObject[@"code"] integerValue] == 200) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:resposeObject[@"data"]];
                [tempDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[NSNull class]]) {
                        
                        [tempDic setObject:@"" forKey:key];
                    }
                }];
                [UserModel defaultModel].absolute_address = tempDic[@"absolute_address"];
                [UserModel defaultModel].account = tempDic[@"account"];
                [UserModel defaultModel].birth = tempDic[@"birth"];
                [UserModel defaultModel].city = tempDic[@"city"];
                [UserModel defaultModel].district = tempDic[@"district"];
                [UserModel defaultModel].head_img = tempDic[@"head_img"];
                [UserModel defaultModel].name = tempDic[@"name"];
                [UserModel defaultModel].sex = tempDic[@"sex"];
                [UserModel defaultModel].tel = tempDic[@"tel"];
                [UserModel defaultModel].province = tempDic[@"province"];
                [UserModelArchiver archive];
//                [self->_table reloadData];
            }else{
                
                [self showContent:resposeObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            
            [self showContent:@"未获取到用户信息，请重试"];
        }];
    };
    [self.navigationController pushViewController:nextVC animated:YES];
}


- (UIView *)navBackgroundView {
    
    if (!_navBackgroundView) {
        _navBackgroundView = [[UIView alloc] init];
        
        _navBackgroundView.frame = CGRectMake(0, 0, SCREEN_Width, NAVIGATION_BAR_HEIGHT);
        
        _navBackgroundView.backgroundColor = [UIColor whiteColor];
//        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_Width, 44)];
//                imageview.image = [UIImage imageNamed:@"nav-beijingtu.png"];
//
//        [_navBackgroundView addSubview:imageview];
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT - SIZE, SCREEN_Width, SIZE)];
        _line.backgroundColor = CLLineColor;
        [_navBackgroundView addSubview:_line];
        
    }
    return _navBackgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.center = CGPointMake(SCREEN_Width / 2, STATUS_BAR_HEIGHT+22 );
        _titleLabel.bounds = CGRectMake(0, 0, 180 * SIZE, 44);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:17 * SIZE];
    }
    return _titleLabel;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _maskButton.frame = CGRectMake(0, 20 * SIZE, 60 * SIZE, 44);
        _leftButton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 60 * SIZE, 44);
        [_leftButton setBackgroundColor:[UIColor clearColor]];
        [_leftButton setImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(ActionMaskBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.center = CGPointMake(SCREEN_Width - 25 * SIZE, STATUS_BAR_HEIGHT+20);
        _rightBtn.bounds = CGRectMake(0, 0, 80 * SIZE, 33 * SIZE);
        //        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:13 * SIZE];
        _rightBtn.hidden = YES;
    }
    return _rightBtn;
}

@end
