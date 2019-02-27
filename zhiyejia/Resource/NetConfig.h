//
//  NetConfig.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#ifndef NetConfig_h
#define NetConfig_h

#pragma mark ---  基础接口  ---

//基础接口测试
static NSString *const TestBase_Net = @"http://120.27.21.136:2798/";

#pragma mark -- 登录、注册 --

//登录
static NSString *const Login_URL = @"user/login";

//登出
static NSString *const LogOut_URL = @"user/logOut";

//发送验证码
static NSString *const Captcha_URL = @"user/captcha";

//注册
static NSString *const Register_URL = @"user/register";

//忘记密码
static NSString *const ResetPassword_URL = @"user/user/resetPassword";
#pragma mark ---  房源  ---

//房源列表
static NSString *const HomeProjectList_URL = @"home/project/list";

//项目详情
static NSString *const HomeProjectDetail_URL = @"home/project/detail";


#endif /* NetConfig_h */
