//
//  RoomChildVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "NewRoomCell.h"

//#import "NewRoomModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RoomChildVCNewRoomProjectBlock)(NewRoomModel *model);

@interface RoomChildVC : BaseViewController

@property (nonatomic, copy) RoomChildVCNewRoomProjectBlock roomChildVCNewRoomProjectBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

@property (nonatomic, assign) BOOL isFirstLoading;

- (instancetype)initWithType:(NSInteger )type;

- (void)RequestMethod;

@end

NS_ASSUME_NONNULL_END
