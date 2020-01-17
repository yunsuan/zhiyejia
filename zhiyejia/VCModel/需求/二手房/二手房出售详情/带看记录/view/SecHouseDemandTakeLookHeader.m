//
//  SecHouseDemandTakeLookHeader.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/3.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseDemandTakeLookHeader.h"

@implementation SecHouseDemandTakeLookHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _sevenL.text = [NSString stringWithFormat:@"%@",dataDic[@"range_take"]];
    _seeL.text = [NSString stringWithFormat:@"%@",dataDic[@"total_take"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBlueBtnColor;
    
    NSArray *titleArr = @[@"近7日带看",@"累计"];
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 2 * i, 15 *SIZE, SCREEN_Width / 2, 13 *SIZE)];
        label.textColor = CLWhiteColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 2 * i, 35 *SIZE, SCREEN_Width / 2, 11 *SIZE)];
        label1.textColor = CLWhiteColor;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.adjustsFontSizeToFitWidth = YES;
        label1.text = titleArr[i];
        [self.contentView addSubview:label1];
        switch (i) {
            case 0:
            {
                _sevenL = label;
                [self.contentView addSubview:_sevenL];
                break;
            }
            case 1:
            {
                _seeL = label;
                [self.contentView addSubview:_seeL];
                break;
            }
            default:
                break;
        }
    }
//    CGRectMake(SCREEN_Width / 4 * i, 35 *SIZE, SCREEN_Width / 4, 13 *SIZE)
    [_sevenL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 2);
        make.bottom.equalTo(self.contentView).offset(-35 *SIZE);
    }];
    
//    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(SCREEN_Width / 2);
//        make.top.equalTo(self.contentView).offset(15 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width / 2);
//        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
//    }];
}

@end
