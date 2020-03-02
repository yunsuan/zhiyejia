//
//  BoxView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BoxView.h"
#import "BoxViewCell.h"

@interface BoxView()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSString *_ID;
    NSString *_str;
}
@end

@implementation BoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _dataArr = [[NSMutableArray alloc] init];
        _selectArr = [[NSMutableArray alloc] init];
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.confirmBtnBlock) {
        
        [_selectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if ([obj integerValue] == 1) {
                
                _ID = _dataArr[idx][@"id"];
                _str = _dataArr[idx][@"param"];
                *stop = YES;
            }
        }];
        self.confirmBtnBlock(_ID,_str);
    }
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.cancelBtnBlock) {
        
        self.cancelBtnBlock();
        [self removeFromSuperview];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BoxViewCell"];
    if (!cell) {
        
        cell = [[BoxViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BoxViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([_selectArr[indexPath.row] integerValue] == 1) {
        
        cell.titleL.textColor = CLBlueBtnColor;
    }else{
        
        cell.titleL.textColor = CL86Color;
    }
    
    if (indexPath.row == 0) {
        
        cell.titleL.text = @"不限";
    }else{
        
        cell.titleL.text = _dataArr[indexPath.row][@"param"];
        cell.typeID = _dataArr[indexPath.row][@"id"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BoxViewCell *cell = (BoxViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    cell.titleL.textColor = CLBlueBtnColor;
    _ID = cell.typeID;
    
    [_selectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx == indexPath.row) {
            
            [_selectArr replaceObjectAtIndex:idx withObject:@(1)];
        }else{
            
            [_selectArr replaceObjectAtIndex:idx withObject:@(0)];
        }
    }];
    [tableView reloadData];
}



- (void)initUI{
    
//    if (@available(iOS 13.0, *)) {
//
//        [self setOverrideUserInterfaceStyle:UIUserInterfaceStyleLight];
//    } else {
//        // Fallback on earlier versions
//    }
    
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionTap)];
    [backView addGestureRecognizer:tap];
    [self addSubview:backView];

    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 243 *SIZE)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    for (int i = 0; i < 2; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(66 *SIZE + i * 125 *SIZE, 188 *SIZE, 100 *SIZE, 33 *SIZE);
        if (i == 0) {
            
            
            [btn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:CL86Color forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            btn.layer.cornerRadius = 2 *SIZE;
            btn.layer.borderColor = COLOR(170, 170, 170, 1).CGColor;
            btn.clipsToBounds = YES;
            btn.layer.borderWidth = SIZE;
            [whiteView addSubview:btn];
        }else{
            
            [btn setTitle:@"确定" forState:UIControlStateNormal];
            [btn setBackgroundColor:COLOR(130, 200, 255, 1)];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
            btn.layer.cornerRadius = 2 *SIZE;
            btn.clipsToBounds = YES;
            [btn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
            [whiteView addSubview:btn];
        }
    }
    
    [self addSubview:self.mainTable];
    
}

- (UITableView *)mainTable{
    
    if (!_mainTable) {
        
        _mainTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 160 *SIZE) style:UITableViewStylePlain];
//        _mainTable.backgroundColor = COLOR(202, 201, 201, 1);
        _mainTable.backgroundColor = [UIColor whiteColor];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _mainTable.tableFooterView = [[UIView alloc] init];
    }
    return _mainTable;
}

- (void)ActionTap{
    if (self.cancelBtnBlock) {
        
        self.cancelBtnBlock();
    }
    
    if (self.superview) {
        [self removeFromSuperview];
    }
}


@end
