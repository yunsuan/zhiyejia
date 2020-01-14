//
//  SecRoomProjectDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "SecProjectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecRoomProjectDetailVC : BaseViewController

@property (nonatomic, strong) NSString *type;

- (instancetype)initWithProjectId:(NSString *)project_id infoId:(NSString *)info_id city:(NSString *)city;

@end

NS_ASSUME_NONNULL_END
