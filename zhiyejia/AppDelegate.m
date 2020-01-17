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

//云渠道百度地图
static NSString *const kBaiduSDK = @"KUHjui3ENsYlHml2lOqGUGOLhuPDDbWq";
//云渠道极光
static NSString *const kJpushAPPKey = @"724cb51c64ef6721d1773d9a";


@interface AppDelegate ()<BMKLocationAuthDelegate>
{
    
    UpgradeTipsView *_updateView;
}
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:kBaiduSDK authDelegate:self];
    // 要使用百度地图，请先启动BaiduMapManager
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [mapManager start:kBaiduSDK  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }

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

- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    
    NSLog(@"%ld",iError);
}


- (void)NetWorkingRequest{
    
    [BaseRequest GET:ProjectResources_URL parameters:nil success:^(id resposeObject) {
        
        if ([resposeObject[@"code"] integerValue] == 200) {
        
            NSArray *arr = resposeObject[@"data"];
            NSMutableDictionary *dic =[NSMutableDictionary dictionary];
            NSMutableArray *allarr = [NSMutableArray array];
            NSMutableArray *selctarr = [NSMutableArray array];
            for (NSUInteger i = 0; i < arr.count; i++) {
                [dic setValue:arr[i] forKey:arr[i][@"tag"]];
                [allarr addObject:arr[i][@"tag"]];
            }
            [UserModel defaultModel].tagDic = dic;
            [UserModel defaultModel].tagAllArr = allarr;
            if (![UserModel defaultModel].tagSelectArr) {
                
                for (NSUInteger i = 0; i < 5; i++) {
                    [selctarr addObject:arr[i][@"tag"]];
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
                        
                        self->_updateView = [[UpgradeTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                        self->_updateView.contentL.text = dic[@"releaseNotes"];
                        self->_updateView.upgradeTipsViewBlock = ^{
                            
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1377016786?mt=8"]];
                        };
                        if ([resposeObject[@"data"][@"must"] integerValue]) {

                            self->_updateView.cancelBtn.hidden = YES;
                        }
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
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
