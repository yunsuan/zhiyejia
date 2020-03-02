//
//  AgentDetailVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentDetailVCBlock)(NSString *str);

@interface AgentDetailVC : BaseViewController

@property (nonatomic, copy) AgentDetailVCBlock agentDetailVCBlock;

- (instancetype)initWithAgentId:(NSString *)agent_id;

@end

NS_ASSUME_NONNULL_END
