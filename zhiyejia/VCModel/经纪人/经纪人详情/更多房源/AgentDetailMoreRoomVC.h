//
//  AgentDetailMoreRoomVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentDetailMoreRoomVCBlock)(void);

@interface AgentDetailMoreRoomVC : BaseViewController

@property (nonatomic, copy) AgentDetailMoreRoomVCBlock agentDetailMoreRoomVCBlock;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *configArr;

- (instancetype)initWithAgentId:(NSString *)agent_id;

@end

NS_ASSUME_NONNULL_END
