//
//  SecHouseBuyDemandDetailRecommendLookRecordCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/7.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyDemandDetailRecommendLookRecordCellPhoneBlock)(void);

@interface SecHouseBuyDemandDetailRecommendLookRecordCell : UITableViewCell

@property (nonatomic, strong) SecHouseBuyDemandDetailRecommendLookRecordCellPhoneBlock secHouseBuyDemandDetailRecommendLookRecordCellPhoneBlock;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
