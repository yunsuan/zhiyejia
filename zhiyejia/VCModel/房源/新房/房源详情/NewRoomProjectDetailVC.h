//
//  NewRoomProjectDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "NewRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomProjectDetailVC : BaseViewController

//- (instancetype)initWithProjectId:(NSString *)projectId;
- (instancetype)initWithModel:(NewRoomModel *)model;

@end

NS_ASSUME_NONNULL_END
