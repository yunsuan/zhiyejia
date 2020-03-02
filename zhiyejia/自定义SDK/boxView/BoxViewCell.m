//
//  BoxViewCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BoxViewCell.h"

@implementation BoxViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    if (@available(iOS 13.0, *)) {
        
        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
    } else {
        // Fallback on earlier versions
    }
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 300 *SIZE, 11 *SIZE)];
    _titleL.textColor = CL86Color;
    _titleL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_titleL];
}

//- (void)setSelected:(BOOL)selected{
//    
//    if (selected) {
//        
//        _titleL.textColor = YJBlueBtnColor;
//    }else{
//        
//        _titleL.textColor = YJ86Color;
//    }
//}

@end
