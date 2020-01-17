//
//  SecHouseBuyDemandDetailHouseCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecHouseBuyDemandDetailRecommendCell : UITableViewCell

@property (nonatomic, strong) UIImageView *agentImg;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

NS_ASSUME_NONNULL_END
