//
//  AgentDetailMoreCommentVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentDetailMoreCommentVCBlock)(void);

@interface AgentDetailMoreCommentVC : BaseViewController

@property (nonatomic, copy) AgentDetailMoreCommentVCBlock agentDetailMoreCommentVCBlock;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *configArr;

- (instancetype)initWithAgentId:(NSString *)agent_id;

@end

NS_ASSUME_NONNULL_END
