//
//  SecHouseSaleDemandDetailAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseSaleDemandDetailAgentCellWorkBlock)(void);

typedef void(^SecHouseSaleDemandDetailAgentCellPhoneBlock)(void);

typedef void(^SecHouseSaleDemandDetailAgentCellChangeBlock)(void);

@interface SecHouseSaleDemandDetailAgentCell : UITableViewCell

@property (nonatomic, copy) SecHouseSaleDemandDetailAgentCellWorkBlock secHouseSaleDemandDetailAgentCellWorkBlock;

@property (nonatomic, copy) SecHouseSaleDemandDetailAgentCellPhoneBlock secHouseSaleDemandDetailAgentCellPhoneBlock;

@property (nonatomic, copy) SecHouseSaleDemandDetailAgentCellChangeBlock secHouseSaleDemandDetailAgentCellChangeBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *professionL;

@property (nonatomic, strong) UILabel *serviceL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIButton *changeBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
