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
//static NSString *const TestBase_Net = @"http://120.27.21.136:2798/";

static NSString *const TestBase_Net = @"http://47.107.246.94/";

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

//上传文件
static NSString *const UserFileUpload_URL = @"user/file/upload";

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

//推荐列表
static NSString *const RecommendGetList_URL = @"home/recommend/getList";
//
//房源-关注
static NSString *const UserFocusNews_URL = @"home/focusNews/list";

#pragma mark -- 新房
//获取源标签
static NSString *const ProjectResources_URL = @"user/project/resources";

//房源列表
static NSString *const HomeProjectList_URL = @"home/project/list";

//项目详情
static NSString *const HomeProjectDetail_URL = @"home/project/detail";

////获取项目的具体信息
static NSString *const ProjectBuildInfo_URL = @"home/project/buildInfo/v2.7";
//
//获取动态列表
//static NSString *const DynamicList_URL = @"user/dynamic/list/v2.7";
//
//获取项目图片
static NSString *const GetImg_URL = @"home/img/get/v2.7";

//获取楼栋
static NSString *const GetBuilding_URL = @"user/yunsuan/build";

//获取所有楼栋
static NSString *const GetAllBuilding_URL = @"user/yunsuan/buildAll";

//获取单元
static NSString *const GetUnit_URL = @"user/yunsuan/unit";

//取消订阅项目
static NSString *const CancelFocusProject_URL = @"home/personal/cancelFocusProject";

//订阅项目
static NSString *const PersonalFocusProject_URL = @"home/personal/focusProject";

//金牌经纪人详情
static NSString *const GetAgentRankDetail_URL = @"home/agent/getAgentRankDetail";

//点赞经纪人
static NSString *const GetAwesomeOperate_URL = @"home/agent/getAwesomeOperate";

//活动列表
static NSString *const GetProjectActiveList_URL = @"home/project/getProjectActiveList";

//户型详情
static NSString *const HouseTypeDetail_URL = @"home/houseType/detail";

#pragma mark -- 二手房 --
//项目列表
static NSString *const HouseProjectList_URL = @"home/house/project/list";

//二手房源
static NSString *const HouseList_URL = @"home/house/list";

//项目详情
static NSString *const HomeHouseProjectDetail_URL = @"home/house/project/detail";

//房源详情
static NSString *const HouseHouseDetail_URL = @"home/house/detail";

//成交详情
static NSString *const ProjectGetHouseDealList_URL = @"home/project/getHouseDealList";
#pragma mark -- 租房 --

//项目列表
static NSString *const RentProjectList_URL = @"home/rent/project/list";
//
//房源列表
static NSString *const RentHouseList_URL = @"home/rent/house/list";

//项目详情
static NSString *const HomeRentProjectDetail_URL = @"home/rent/project/detail";

//房源详情
static NSString *const RentHouseDetail_URL =  @"home/rent/house/detail";

#pragma mark ---  需求  ---

//获取平台开放城市
static NSString *const ForunOpenCityList_URL = @"user/forum/openCity/list";

//获取平台开放区域
static NSString *const ForumOpenDistrictList_URL = @"user/forum/openDistrict/list";
#pragma mark -- 求购 --
//列表
static NSString *const NeedBuyList_URL =  @"home/need/buy/list";

//添加
static NSString *const NeedBuyAdd_URL = @"home/need/buy/add";

//待确认详情
static NSString *const NeedBuyWaitDeail_URL = @"home/need/buy/wait/detail";

//已确认详情
static NSString *const NeedBuyValueDeail_URL = @"home/need/buy/value/detail";

//取消发布
static NSString *const NeedBuyBuyCancel_URL = @"home/need/buy/buy/cancel";

#pragma mark -- 出售 --

//添加
static NSString *const NeedSaleAdd_URL = @"home/need/sale/add";

//项目列表
static NSString *const NeedHouseProjectList_URL = @"home/need/house/project/list";

//列表
static NSString *const NeedSaleList_URL = @"home/need/sale/list";

//取消发布
static NSString *const NeedSaleCancel_URL = @"home/need/sale/cancel";

//待确认详情
static NSString *const NeedSaleWaitDeail_URL = @"home/need/sale/wait/detail";

//有效详情
static NSString *const NeedSaleValueDeail_URL = @"home/need/sale/value/detail";

//带看房源带看记录
static NSString *const TakeMaintainHouseDetail_URL = @"home/take/maintain/house/detail";
#endif /* NetConfig_h */
