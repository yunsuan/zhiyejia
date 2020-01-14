//
//  UserModelArchiver.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "UserModelArchiver.h"

@implementation UserModelArchiver

+ (UserModel *)unarchive {
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self archivePath]];
}

+ (void)archive {
    
    BOOL flag = [NSKeyedArchiver archiveRootObject:[UserModel defaultModel] toFile:[self archivePath]];
    if (!flag) {
        //        NSLog(@"归档失败!");
    }
}


+ (NSString *)archivePath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    //    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *basePath = paths.firstObject;
    
    return [basePath stringByAppendingPathComponent:@"UserModel.dat"];
    
}

+ (void)ClearUserInfoModel{
    
    UserModel *model = [[UserModel alloc]init];
    if ([UserModel defaultModel].phone.length) {
        
        model.phone = [UserModel defaultModel].phone;
        model.passWord = [UserModel defaultModel].passWord;
        model.cityArr = [UserModel defaultModel].cityArr;
        model.tagDic = [UserModel defaultModel].tagDic;
        model.tagAllArr = [UserModel defaultModel].tagAllArr;
        model.tagSelectArr = [UserModel defaultModel].tagSelectArr;
    }
    [UserModel defaultModel].time = @"";
    [UserModel defaultModel].token = @"";
    [UserModel defaultModel].absolute_address = @"";
    [UserModel defaultModel].account = @"";
    [UserModel defaultModel].birth = @"";
    [UserModel defaultModel].city = @"";
    [UserModel defaultModel].district = @"";
    [UserModel defaultModel].head_img = @"";
    [UserModel defaultModel].name = @"";
    [UserModel defaultModel].province = @"";
    [UserModel defaultModel].sex = @"";
    [UserModel defaultModel].tel = @"";
    [UserModelArchiver archive];
//    [UserModel defaultModel].cityArr = [@[] mutableCopy];
//    [UserModel defaultModel].tagDic = [@{} mutableCopy];
//    [UserModel defaultModel].tagAllArr = [@[] mutableCopy];
//    [UserModel defaultModel].tagSelectArr = [@[] mutableCopy];
    BOOL flag = [NSKeyedArchiver archiveRootObject:model toFile:[self archivePath]];
    if (!flag) {
        
        NSLog(@"清空用户信息失败!");
    }
}

@end
