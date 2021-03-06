//
//  RoomChildVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

#import "NewRoomCell.h"
#import "SecRoomCell.h"
#import "RentRoomCell.h"

#import "AttentionHouseCell.h" //二手房
#import "AttentionComCell.h" //二手房

#import "SecHouseCell.h"
#import "RentHouseCell.h"


NS_ASSUME_NONNULL_BEGIN

typedef void(^RoomChildVCNewRoomProjectBlock)(NewRoomModel *model);

typedef void(^RoomChildVCSecRoomProjectBlock)(SecProjectModel *model);

typedef void(^RoomChildVCRentRoomProjectBlock)(RentProjectModel *model);

typedef void(^RoomChildVCSecRoomHouseBlock)(SecHouseModel *model);

typedef void(^RoomChildVCRentRoomHouseBlock)(RentHouseModel *model);

typedef void(^RoomChildVCAttentionSecHouseBlock)(AttentionHouseModel *model);

typedef void(^RoomChildVCAttentionSecRoomBlock)(AttetionComModel *model);

@interface RoomChildVC : BaseViewController

@property (nonatomic, copy) RoomChildVCNewRoomProjectBlock roomChildVCNewRoomProjectBlock;

@property (nonatomic, copy) RoomChildVCSecRoomProjectBlock roomChildVCSecRoomProjectBlock;

@property (nonatomic, copy) RoomChildVCRentRoomProjectBlock roomChildVCRentRoomProjectBlock;

@property (nonatomic, copy) RoomChildVCSecRoomHouseBlock roomChildVCSecRoomHouseBlock;

@property (nonatomic, copy) RoomChildVCRentRoomHouseBlock roomChildVCRentRoomHouseBlock;

@property (nonatomic, copy) RoomChildVCAttentionSecRoomBlock roomChildVCAttentionSecRoomBlock;

@property (nonatomic, copy) RoomChildVCAttentionSecHouseBlock roomChildVCAttentionSecHouseBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *typeId;

@property (nonatomic, strong) NSString *param;

@property (nonatomic, assign) BOOL isFirstLoading;

- (instancetype)initWithType:(NSInteger )type;

- (void)RequestMethod;

@end

NS_ASSUME_NONNULL_END
