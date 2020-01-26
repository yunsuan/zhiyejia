//
//  AppDelegate.m
//  zhiyejia
//
//  Created by xiaoq on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//
#import <BMKLocationkit/BMKLocationComponent.h>

#import "AppDelegate.h"
#import "UpgradeTipsView.h"

#import "CYLTabBarControllerConfig.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


//云渠道百度地图
static NSString *const kBaiduSDK = @"KUHjui3ENsYlHml2lOqGUGOLhuPDDbWq";
//云渠道极光
static NSString *const kJpushAPPKey = @"724cb51c64ef6721d1773d9a";


@interface AppDelegate ()<BMKLocationAuthDelegate,JPUSHRegisterDelegate>
{
    
    UpgradeTipsView *_updateView;
}
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goHome) name:@"goHome" object:nil];
    //注册通知，退出登陆时回到首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(comeBackLoginVC) name:@"goLoginVC" object:nil];
    
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:kBaiduSDK authDelegate:self];
    // 要使用百度地图，请先启动BaiduMapManager
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [mapManager start:kBaiduSDK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    //极光配置
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if (@available(iOS 10.0, *)) {
        [JPUSHService registerForRemoteNotificationTypes:(UNNotificationPresentationOptionAlert |UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound) categories:nil];
    } else {
        // Fallback on earlier versions
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil];
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:kJpushAPPKey
                          channel:@"appstore"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            [self SetTagsAndAlias];
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [self NetWorkingRequest];
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
//    [[UIApplication sharedApplication].keyWindow setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    if (@available(iOS 13.0, *)) {
        
        [_window setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    } else {
        // Fallback on earlier versions
    }
    _window.rootViewController = tabBarControllerConfig.tabBarController;
//    _window.keyWindow
    return YES;
}

- (void)SetTagsAndAlias{
    
    if ([UserModel defaultModel].token) {
        NSSet *tags;
        
        [JPUSHService setAlias:[NSString stringWithFormat:@"user_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
        } seq:0];
    }
}

- (void)goHome{
    
    NSSet *tags;
    
    [JPUSHService setAlias:[NSString stringWithFormat:@"user_%@",[UserModel defaultModel].agent_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);;
    } seq:0];
}

- (void)comeBackLoginVC {
    //未登录
    NSSet *tags;
    
    [JPUSHService setAlias:@"exit" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {

        NSLog(@"rescode: %ld, \ntags: %@, \nalias: %@\n", (long)iResCode, tags , iAlias);
    } seq:0];
}

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    
    NSLog(@"%ld",iError);
}


- (void)NetWorkingRequest{
    
    [BaseRequest GET:ProjectResources_URL parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
        
            NSArray *arr = resposeObject[@"data"];
            NSMutableArray *tempArr = [@[] mutableCopy];
            for (int i = 0; i < arr.count; i++) {
                
                if ([arr[i][@"tag"] isEqualToString:@"推荐"]) {
                    
                }else{
                    
                    [tempArr addObject:arr[i]];
                }
            }
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            NSMutableArray *allarr = [NSMutableArray array];
            NSMutableArray *selctarr = [NSMutableArray array];
            for (NSUInteger i = 0; i < tempArr.count; i++) {
                if ([tempArr[i][@"tag"] isEqualToString:@"推荐"]) {
                    
                }else{
                    
                    [dic setValue:tempArr[i] forKey:tempArr[i][@"tag"]];
                    [allarr addObject:tempArr[i][@"tag"]];
                }
            }
            [UserModel defaultModel].tagDic = dic;
            [UserModel defaultModel].tagAllArr = allarr;
            if (![UserModel defaultModel].tagSelectArr) {
                
                for (NSUInteger i = 0; i < 5; i++) {
                    [selctarr addObject:tempArr[i][@"tag"]];
                }
                [UserModel defaultModel].tagSelectArr = selctarr;
            }
            [UserModelArchiver archive];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)UpdateRequest{
    
    [BaseRequest VersionUpdateSuccess:^(id  _Nonnull resposeObject) {
        
        NSLog(@"%@",resposeObject);
        NSArray *array = resposeObject[@"results"];
        if (array.count) {
         
            NSDictionary *dic = array[0];
            NSString *appStoreVersion = dic[@"version"];
            if ([[appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue] > [[YQDversion stringByReplacingOccurrencesOfString:@"." withString:@""] floatValue]) {
            
                [BaseRequest GET:@"getHomeVersionInfo" parameters:nil success:^(id resposeObject) {
                    
                    if ([resposeObject[@"code"] integerValue] == 200) {
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            [self->_updateView removeFromSuperview];
                            self->_updateView = [[UpgradeTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                            self->_updateView.contentL.text = dic[@"releaseNotes"];
                            self->_updateView.upgradeTipsViewBlock = ^{
                                
                                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1377016786?mt=8"]];
                            };
                            if ([resposeObject[@"data"][@"must"] integerValue]) {

                                self->_updateView.cancelBtn.hidden = YES;
                            }
                            
                            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self->_updateView];
                        });
                    }
                } failure:^(NSError *error) {
                    
                }];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    [self UpdateRequest];
}

#pragma mark ---  Jpush  ---

//极光方法

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    [application registerForRemoteNotifications];
}


//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

//实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    
//    NSDictionary * userInfo = notification.request.content.userInfo;
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler API_AVAILABLE(ios(10.0)){
    
    NSDictionary * userInfo = notification.request.content.userInfo;
//    UNNotificationRequest *request = notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"22222222%@",userInfo);
    
    
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{userInfo：%@\n}",userInfo);
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}


- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
//    UNNotificationContent *content = request.content; // 收到推送的消息内容
//
//    NSNumber *badge = content.badge;  // 推送消息的角标
//    NSString *body = content.body;    // 推送消息体
//    UNNotificationSound *sound = content.sound;  // 推送消息的声音
//    NSString *subtitle = content.subtitle;  // 推送消息的副标题
//    NSString *title = content.title;  // 推送消息的标题
    NSLog(@"1111111%@",userInfo);
    
    
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{userInfo：%@\n}",userInfo);
    }
    
    //    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:[badge integerValue]];
    [UIApplication sharedApplication].applicationIconBadgeNumber += 1;
    
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    //    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    completionHandler(UIBackgroundFetchResultNewData);
    
//    [self GotoHome];
    if (application.applicationState == UIApplicationStateActive) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
        
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"%@",userInfo);
    application.applicationIconBadgeNumber += 1;
    
    
    
    if (application.applicationState == UIApplicationStateActive) {
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMessList" object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"recommendReload" object:nil];
    }
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self UpdateRequest];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self UpdateRequest];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
