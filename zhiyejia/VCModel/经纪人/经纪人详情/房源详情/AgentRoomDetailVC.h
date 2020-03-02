//
//  AgentRoomDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentRoomDetailVCBlock)(void);

@interface AgentRoomDetailVC : BaseViewController

@property (nonatomic, copy) AgentRoomDetailVCBlock agentRoomDetailVCBlock;

@property (nonatomic, strong) NSString *project_id;

@property (nonatomic, strong) NSString *projectName;

@property (nonatomic, strong) NSString *config_id;

@property (nonatomic, strong) NSString *agent_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *configArr;

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id;

@end

NS_ASSUME_NONNULL_END
