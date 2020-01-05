//
//  SecHouseBuyDemandDetailAgentCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecHouseBuyDemandDetailAgentCellWorkBlock)(void);

typedef void(^SecHouseBuyDemandDetailAgentCellPhoneBlock)(void);

typedef void(^SecHouseBuyDemandDetailAgentCellChangeBlock)(void);

@interface SecHouseBuyDemandDetailAgentCell : UITableViewCell

@property (nonatomic, copy) SecHouseBuyDemandDetailAgentCellWorkBlock secHouseBuyDemandDetailAgentCellWorkBlock;

@property (nonatomic, copy) SecHouseBuyDemandDetailAgentCellPhoneBlock secHouseBuyDemandDetailAgentCellPhoneBlock;

@property (nonatomic, copy) SecHouseBuyDemandDetailAgentCellChangeBlock secHouseBuyDemandDetailAgentCellChangeBlock;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *professionL;

@property (nonatomic, strong) UILabel *serviceL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIButton *changeBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
