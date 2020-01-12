//
//  NewRoomProjectAgentVC.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/5.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewRoomProjectAgentVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

- (instancetype)initWithDataArr:(NSArray *)dataArr;

@end

NS_ASSUME_NONNULL_END
