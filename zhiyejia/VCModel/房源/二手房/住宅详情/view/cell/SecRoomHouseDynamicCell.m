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

- (void)initUI{
    
    NSArray *titleArr = @[@"近7日看房(次)",@"累计看房(次)",@"参考价格(万元)"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
        line.backgroundColor = CLBackColor;
        if (i != 0) {
            
            [self.contentView addSubview:line];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 19 *SIZE, SCREEN_Width / 3, 13 *SIZE)];
        label.textColor = CLBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 41 *SIZE, SCREEN_Width / 3, 11 *SIZE)];
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
        
        
        //        [self.contentView addSubview:label1];
    }
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 75 *SIZE, 60 *SIZE, 11 *SIZE)];
    label2.textColor = CL86Color;
    label2.font = [UIFont systemFontOfSize:12 *SIZE];
    label2.text = @"看房记录";
    [self.contentView addSubview:label2];
    
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
}

@end
