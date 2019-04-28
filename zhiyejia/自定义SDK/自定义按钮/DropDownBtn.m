//
//  DropDownBtn.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/4/26.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "DropDownBtn.h"

@implementation DropDownBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 5*SIZE;
//        self.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
//        self.layer.borderWidth = 1*SIZE;
        [self addSubview:self.content];
        [self addSubview:self.dropimg];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 5*SIZE;
//        self.layer.borderColor = COLOR(219, 219, 219, 1).CGColor;
//        self.layer.borderWidth = 1*SIZE;
        [self addSubview:self.content];
        [self addSubview:self.dropimg];
    }
    return self;
}

-(UILabel *)content
{
    if (!_content) {
        _content = [[UILabel alloc]initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, self.frame.size.width - 24 *SIZE, 14 *SIZE)];
        _content.font = [UIFont systemFontOfSize:13 *SIZE];
        _content.textColor = CLContentLabColor;
        _content.textAlignment = NSTextAlignmentRight;
    }
    return _content;
}

-(UIImageView *)dropimg
{
    if (!_dropimg) {
        
        _dropimg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"downarrow1"]];
        _dropimg.frame = CGRectMake(self.frame.size.width - 14*SIZE, 15 *SIZE, 8 *SIZE, 8 *SIZE);
    }
    return _dropimg;
}

@end
