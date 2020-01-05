//
//  SecHouseSaleDemandDetailCompanyCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseSaleDemandDetailCompanyCellPhoneBlock)(void);

typedef void(^SecHouseSaleDemandDetailCompanyCellExitBlock)(void);

@interface SecHouseSaleDemandDetailCompanyCell : UITableViewCell

@property (nonatomic, copy) SecHouseSaleDemandDetailCompanyCellPhoneBlock secHouseSaleDemandDetailCompanyCellPhoneBlock;

@property (nonatomic, copy) SecHouseSaleDemandDetailCompanyCellExitBlock secHouseSaleDemandDetailCompanyCellExitBlock;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *companyL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIButton *exitBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
