//
//  SecRoomHouseDynamicCell.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/3/4.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "SecRoomHouseDynamicCell.h"

@implementation SecRoomHouseDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    if (dataDic[@"range_take"]) {
        
        _daysL.text = [NSString stringWithFormat:@"%@",dataDic[@"range_take"]];
    }else{
        
        _daysL.text = @"0";
    }
    if (dataDic[@"total_take"]) {
        
        _allL.text = [NSString stringWithFormat:@"%@",dataDic[@"total_take"]];
    }else{
        
        _allL.text = @"0";
    }
    if (dataDic[@"suggest_price"]) {
        
        _intentL.text = [NSString stringWithFormat:@"%@",dataDic[@"suggest_price"]];
    }else{
        
        _intentL.text = @"0";
    }
}

- (void)initUI{
    
    NSArray *titleArr = @[@"近7日看房(次)",@"累计看房(次)",@"参考价格(万元)"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
        line.backgroundColor = CLBackColor;
        if (i != 0) {
            
            [self.contentView addSubview:line];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 19 *SIZE, SCREEN_Width / 3, 14 *SIZE)];
        label.textColor = CLBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 41 *SIZE, SCREEN_Width / 3, 12 *SIZE)];
        label1.textColor = CL86Color;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = titleArr[i];
        
        switch (i) {
            case 0:
            {
                _daysL = label;
                [self.contentView addSubview:_daysL];
                _daysLabel = label1;
                [self.contentView addSubview:_daysLabel];
                break;
            }
            case 1:
            {
                _allL = label;
                [self.contentView addSubview:_allL];
                _allLabel = label1;
                [self.contentView addSubview:_allLabel];
                break;
            }
            case 2:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                _intentLabel = label1;
                [self.contentView addSubview:_intentLabel];
                break;
            }
            default:
                break;
        }
    }
        
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_daysL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_daysLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self->_daysL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_allL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120*SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(120*SIZE);
        make.top.equalTo(self->_allL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240*SIZE);
        make.top.equalTo(self.contentView).offset(23 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
    }];
    
    [_intentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(240*SIZE);
        make.top.equalTo(self->_intentL.mas_bottom).offset(12 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
