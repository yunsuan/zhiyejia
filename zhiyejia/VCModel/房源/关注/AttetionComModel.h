//
//  AttetionComModel.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "SecdaryComModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttetionComModel : SecdaryComModel

@property (nonatomic, strong) NSString *detail_get;

@property (nonatomic, strong) NSMutableArray *commentList;

@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *type;

@end

NS_ASSUME_NONNULL_END
