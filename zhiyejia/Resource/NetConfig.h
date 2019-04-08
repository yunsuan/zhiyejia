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

#pragma mark ---  我的  ---

//获取个人信息
static NSString *const PersonalGetAgentInfo_URL = @"user/personal/getAgentInfo";

//修改个人信息
static NSString *const PersonalChangeAgentInfo_URL = @"user/personal/changeAgentInfo";

//修改密码
static NSString *const ChangePassWord_URL = @"user/changePassword";

//关注房源列表
static NSString *const PersonalGetSubList_URL = @"user/personal/getSubList";

//关注房源
static NSString *const PersonalFocusHouse_URL = @"user/personal/focusHouse";

//取关房源
static NSString *const PersonalCancelFocusHouse_URL = @"user/personal/cancelFocusHouse";

//我关注的经纪人
static NSString *const PersonalGetFocusAgent_URL = @"user/personal/getfocusAgent";

//关注经纪人
static NSString *const PersonalCancelFocusAgent_URL = @"user/personal/cancelFocusAgent";

//取关经纪人
static NSString *const PersonalFocusAgent_URL = @"user/personal/focusAgent";

//我的订阅
static NSString *const PersonalGetFocusProjectList_URL = @"user/personal/getFocusProjectList";

//订阅
static NSString *const PersonalFocusProjectList_URL = @"user/personal/focusProject";

//取消订阅
static NSString *const PersonalCancelFocusProjectList_URL = @"user/personal/cancelFocusProject";

//意见反馈
static NSString *const PersonalSendAdvice_URL = @"user/personal/sendAdvice";
#pragma mark ---  房源  ---

//获取开放区域
static NSString *const OpenCity_URL = @"user/project/openCity";

#pragma mark -- 推荐 --

//推荐
static NSString *const ProjectRecommendInfo_URL = @"user/project/recommendInfo";

//房源-关注
static NSString *const UserFocusNews_URL = @"user/focusNews/list";

#pragma mark -- 新房
//获取源标签
static NSString *const ProjectResources_URL = @"user/project/resources";

//房源列表
static NSString *const HomeProjectList_URL = @"home/project/list";

//项目详情
static NSString *const HomeProjectDetail_URL = @"home/project/detail";

//获取项目图片
static NSString *const GetImg_URL = @"user/img/get/v2.7";

//获取楼栋
static NSString *const GetBuilding_URL = @"user/yunsuan/build";

//取消订阅项目
static NSString *const CancelFocusProject_URL = @"agent/personal/cancelFocusProject";

//订阅项目
static NSString *const PersonalFocusProject_URL = @"agent/personal/focusProject";

#pragma mark -- 二手房 --
//项目列表
static NSString *const HouseProjectList_URL = @"user/house/project/list";

//房源列表
static NSString *const HouseHouseList_URL = @"user/house/house/list";

//项目详情
static NSString *const HomeHouseProjectDetail_URL = @"home/house/project/detail";

//房源详情
static NSString *const HouseHouseDetail_URL = @"user/house/house/detail";

#pragma mark -- 租房 --

//项目列表
static NSString *const RentProjectList_URL = @"user/rent/project/list";

//房源列表
static NSString *const RentHouseList_URL = @"user/rent/house/list";

//项目详情
static NSString *const HomeRentProjectDetail_URL = @"home/rent/project/detail";

//房源详情
static NSString *const RentHouseDetail_URL =  @"user/rent/house/detail";
#endif /* NetConfig_h */
