//
//  SecHouseBuyDemandDetailRecommendPriceCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/8.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseBuyDemandDetailRecommendPriceCell.h"

@implementation SecHouseBuyDemandDetailRecommendPriceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _priceL.text = @"10";
    _unitL.text = @"10";
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBlueBtnColor;
    
    NSArray *titleArr = @[@"挂牌均价",@"主流挂牌价"];
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 2 * i, 35 *SIZE, SCREEN_Width / 2, 13 *SIZE)];
        label.textColor = CLWhiteColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 2 * i, 15 *SIZE, SCREEN_Width / 2, 11 *SIZE)];
        label1.textColor = CLWhiteColor;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.text = titleArr[i];
        [self.contentView addSubview:label1];
        switch (i) {
            case 0:
            {
                _unitL = label;
                [self.contentView addSubview:_unitL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                
                break;
            }
            default:
                break;
        }
    }
//    CGRectMake(SCREEN_Width / 4 * i, 35 *SIZE, SCREEN_Width / 4, 13 *SIZE)
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(35 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
