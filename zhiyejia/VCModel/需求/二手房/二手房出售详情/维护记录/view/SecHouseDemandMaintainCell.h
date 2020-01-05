//
//  SecHouseDemandMaintainCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseDemandMaintainCellPhoneBlock)(void);

@interface SecHouseDemandMaintainCell : UITableViewCell

@property (nonatomic, copy) SecHouseDemandMaintainCellPhoneBlock secHouseDemandMaintainCellPhoneBlock;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *detailL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
