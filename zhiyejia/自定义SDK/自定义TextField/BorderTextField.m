//
//  BorderTextField.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BorderTextField.h"

@implementation BorderTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5*SIZE;
        self.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
        self.layer.borderWidth = 1*SIZE;
        [self addSubview:self.textfield];
        [self addSubview:self.unitL];
    }
    return self;
}

-(UITextField *)textfield
{
    if (!_textfield) {
        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(10 *SIZE, 0 *SIZE, self.frame.size.width - 10 *SIZE, self.frame.size.height)];
        _textfield.textColor = CLContentLabColor;
        _textfield.textAlignment = NSTextAlignmentRight;
        _textfield.font = [UIFont systemFontOfSize:(CGFloat) (13 * SIZE)];
    }
    return _textfield;
}

- (UILabel *)unitL{

    if (!_unitL) {

        _unitL = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 40*SIZE, 10 *SIZE, 35 *SIZE, 14 *SIZE)];
        _unitL.textColor = CLContentLabColor;
        _unitL.textAlignment = NSTextAlignmentRight;
        _unitL.font = [UIFont systemFontOfSize:13 *SIZE];
    }
    return _unitL;
}


@end
