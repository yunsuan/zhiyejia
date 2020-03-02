//
//  AgentDetailMoreBtnHeader.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseColorHeader.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AgentDetailMoreBtnHeaderMoreBlock)(void);

typedef void(^AgentDetailMoreBtnHeaderAddBlock)(void);

@interface AgentDetailMoreBtnHeader : BaseColorHeader

@property (nonatomic, copy) AgentDetailMoreBtnHeaderMoreBlock agentDetailMoreBtnHeaderMoreBlock;

@property (nonatomic, copy) AgentDetailMoreBtnHeaderAddBlock agentDetailMoreBtnHeaderAddBlock;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) UIButton *addBtn;

@end

NS_ASSUME_NONNULL_END
