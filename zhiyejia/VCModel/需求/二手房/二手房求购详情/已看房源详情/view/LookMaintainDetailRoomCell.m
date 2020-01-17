//
//  LookMaintainDetailRoomCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "LookMaintainDetailRoomCell.h"

@implementation LookMaintainDetailRoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setData:(NSMutableDictionary *)data{
    
    [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,data[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
            _roomImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    _statusL.text = [NSString stringWithFormat:@"%@",[data[@"house_state"] length]?data[@"house_state"]:@" "];
    _codeL.text = [NSString stringWithFormat:@"%@",[data[@"title"] length]?data[@"title"]:@" "];
    _firstTimeL.text = [NSString stringWithFormat:@"房源编号：%@",[data[@"house_code"]  length]?data[@"house_code"]:@" "];
    _lastTimeL.text = @" ";
    _compL.text = @" ";
    _numL.text = @" ";
    _priceL.text = @" ";
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        if (error) {
            
            _roomImg.image = [UIImage imageNamed:@"default_3"];
        }
    }];
    
    _statusL.text = [NSString stringWithFormat:@"%@",[dataDic[@"house_state"] length]?dataDic[@"house_state"]:@" "];
    
    _contentL.text = [NSString stringWithFormat:@"%@",[dataDic[@"describe"] length]?dataDic[@"describe"]:@" "];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"满意度：%@%@",dataDic[@"intent"],@"%"]];
    [attr addAttribute:NSForegroundColorAttributeName value:CLBlueBtnColor range:NSMakeRange(3, attr.length - 3)];
    _satisfyL.attributedText = attr;
    _codeL.text = [NSString stringWithFormat:@"%@",dataDic[@"title"]];
    _firstTimeL.text = [NSString stringWithFormat:@"首次看房时间：%@",[dataDic[@"first_take_time"] length]?dataDic[@"first_take_time"]:@" "];
    _lastTimeL.text = [NSString stringWithFormat:@"最后看房时间：%@",[dataDic[@"first_take_time"] length]?dataDic[@"first_take_time"]:@" "];
    _compL.text = [NSString stringWithFormat:@"%@",[dataDic[@"finish_state"] length]?dataDic[@"finish_state"]:@" "];
    _numL.text = [NSString stringWithFormat:@"带看次数：%@",dataDic[@"take_num"]];
    NSMutableAttributedString *attrPrice;
    
    if ([dataDic[@"list"][0][@"price"] integerValue] == 0) {
        
        attrPrice = [[NSMutableAttributedString alloc] initWithString:@"最新出价：未出价"];
    }else{
        
        attrPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最新出价：%@万",dataDic[@"price"]]];
//        attrPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最新出价：%.2f万",[dataDic[@"price"] floatValue] / 10000.00]];
    }
    [attrPrice addAttribute:NSForegroundColorAttributeName value:COLOR(255, 70, 70, 1) range:NSMakeRange(5, attrPrice.length - 5)];

    _priceL.attributedText = attrPrice;
}

- (void)initUI{
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.contentMode = UIViewContentModeScaleAspectFill;
    _roomImg.clipsToBounds = YES;
    [self.contentView addSubview:_roomImg];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = [UIColor whiteColor];
    _statusL.font = [UIFont systemFontOfSize:11 *SIZE];
    _statusL.textAlignment = NSTextAlignmentCenter;
    _statusL.backgroundColor = [UIColor blackColor];
    _statusL.alpha = 0.5;
    [_roomImg addSubview:_statusL];
    
    for (int i = 0; i < 8; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = CLContentLabColor;
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        switch (i) {
            case 0:
            {
                _codeL = label;
                _codeL.textColor = CLTitleLabColor;
                _codeL.font = [UIFont systemFontOfSize:13 *SIZE];
                [self.contentView addSubview:label];
                break;
            }
            case 1:
            {
                _satisfyL = label;
                _satisfyL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_satisfyL];
                break;
            }
            case 2:
            {
                _contentL = label;
                _contentL.numberOfLines = 0;
                _contentL.adjustsFontSizeToFitWidth = YES;
                [self.contentView addSubview:_contentL];
                break;
            }
            case 3:
            {
                _compL = label;
                _compL.textAlignment = NSTextAlignmentRight;
                _compL.textColor = COLOR(255, 70, 70, 1);
                [self.contentView addSubview:_compL];
                break;
            }
            case 4:
            {
                _firstTimeL = label;
                [self.contentView addSubview:_firstTimeL];
                break;
            }
            case 5:
            {
                _lastTimeL = label;
                [self.contentView addSubview:_lastTimeL];
                break;
            }
            case 6:
            {
                _numL = label;
                [self.contentView addSubview:_numL];
                break;
            }
            case 7:
            {
                _priceL = label;
                _priceL.textAlignment = NSTextAlignmentRight;
                [self.contentView addSubview:_priceL];
                break;
            }
            default:
                break;
        }
    }
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = CLLineColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_roomImg).offset(0 *SIZE);
        make.top.equalTo(_roomImg).offset(72 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_codeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_satisfyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_contentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_codeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(180 *SIZE);
    }];
    
    [_compL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_satisfyL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(70 *SIZE);
    }];
    
    [_firstTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_contentL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_lastTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_firstTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_numL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_lastTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-12 *SIZE);
        make.top.equalTo(_lastTimeL.mas_bottom).offset(7 *SIZE);
        make.width.mas_equalTo(120 *SIZE);
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_numL.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
