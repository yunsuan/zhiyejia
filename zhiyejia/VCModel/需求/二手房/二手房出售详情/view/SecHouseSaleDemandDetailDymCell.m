//
//  SecHouseSaleDemandDetailDymCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/2.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "SecHouseSaleDemandDetailDymCell.h"

@implementation SecHouseSaleDemandDetailDymCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _sevenL.text = [NSString stringWithFormat:@"%@",dataDic[@"range_take"]];
    _thirtyL.text = [NSString stringWithFormat:@"%@",dataDic[@"total_take"]];
    _intentL.text = [NSString stringWithFormat:@"%@",dataDic[@"focus_num"]];
    _seeL.text = [NSString stringWithFormat:@"%@",dataDic[@"view_num"]];
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLBlueBtnColor;
    
    NSArray *titleArr = @[@"近7日带看（次）",@"总带看（次）",@"关注量",@"浏览量"];
    for (int i = 0; i < 4; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 4 * i, 35 *SIZE, SCREEN_Width / 4, 13 *SIZE)];
        label.textColor = CLWhiteColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.adjustsFontSizeToFitWidth = YES;
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 4 * i, 15 *SIZE, SCREEN_Width / 4, 11 *SIZE)];
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
                _thirtyL = label;
                [self.contentView addSubview:_thirtyL];
                
                break;
            }
            case 2:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                
                break;
            }
            case 3:
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
        make.top.equalTo(self.contentView).offset(35 *SIZE);
        make.width.mas_equalTo(SCREEN_Width / 4);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
