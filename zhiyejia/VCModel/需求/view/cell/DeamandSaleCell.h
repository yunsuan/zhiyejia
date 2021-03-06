//
//  DeamandSaleCell.h
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DeamandSaleCellBlock)(void);

@interface DeamandSaleCell : UITableViewCell

@property (nonatomic, copy) DeamandSaleCellBlock deamandSaleCellBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *houseNumL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
