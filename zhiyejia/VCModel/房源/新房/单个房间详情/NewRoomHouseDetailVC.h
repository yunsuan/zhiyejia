//
//  NewRoomHouseDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/28.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "NewRoomHouseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomHouseDetailVC : BaseViewController

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NewRoomHouseModel *model;

- (instancetype)initWithHouseTypeId:(NSString *)houseTypeId index:(NSInteger)index dataArr:(NSArray *)dataArr projectId:(NSString *)projectId infoid:(NSString *)infoid;

@end

NS_ASSUME_NONNULL_END
