//
//  AgentRoomDetailCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/3/1.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AgentRoomDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) UILabel *propertyL;

@property (nonatomic, strong) UILabel *attentL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *stateL;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
