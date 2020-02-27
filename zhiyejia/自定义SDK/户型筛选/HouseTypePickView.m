//
//  HouseTypePickView.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "HouseTypePickView.h"

#define PICKERHEIGHT 216
#define BGHEIGHT     256

@interface HouseTypePickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    
    NSString *_room;
    NSString *_hall;
    NSString *_bath;
}
/**
 pickerView
 */
@property(nonatomic, strong) UIPickerView * pickerView;
/**
 bgView
 */
@property(nonatomic, strong) UIView * bgView;

/**
 toolBar
 */
@property(nonatomic, strong) UIView * toolBar;

/**
 取消按钮
 */
@property(nonatomic, strong) UIButton * cancleBtn;

/**
 确定按钮
 */
@property(nonatomic, strong) UIButton * sureBtn;

@end

@implementation HouseTypePickView

#pragma mark -- init
- (instancetype)initWithFrame:(CGRect)frame// WithData:(NSArray *)date
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSuViews];
        
        _room = @"0";
        _bath = @"0";
        _hall = @"0";
    }
    return self;
}



//- (NSArray *)dataSource
//{
//    if (!_dataSource) {
//        _dataSource = [NSArray array];
//    }
//    return _dataSource;
//}

#pragma mark -- loadSubViews
- (void)initSuViews
{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolBar];
    [self.bgView addSubview:self.pickerView];
    [self.toolBar addSubview:self.cancleBtn];
    [self.toolBar addSubview:self.sureBtn];
    [self showPickerView];
}

#pragma mark -- showPickerView
- (void)showPickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self->_bgView.frame = CGRectMake(0, self.frame.size.height - BGHEIGHT, self.frame.size.width, BGHEIGHT);
    }];
}


- (void)hidePickerView
{
    [UIView animateWithDuration:0.3 animations:^{
        
        self->_bgView.frame = CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT);
        
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark -- UIPickerView


//UIPickerViewDataSource中定义的方法，该方法的返回值决定该控件包含的列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 3; // 返回1表明该控件只包含1列
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
//    return _dataSource.count;
    return 8;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    return _dataSource[(NSUInteger) row][@"param"];
    if (component == 0) {
        
        return [NSString stringWithFormat:@"%ld室",(long)row];
    }else if (component == 1){
        
        return [NSString stringWithFormat:@"%ld厅",(long)row];
    }else{
        
        return [NSString stringWithFormat:@"%ld卫",(long)row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
        _room = [NSString stringWithFormat:@"%ld",(long)row];
    }else if (component == 1){
        
        _hall = [NSString stringWithFormat:@"%ld",(long)row];
    }else{
        
        _bath = [NSString stringWithFormat:@"%ld",(long)row];
    }
//    _name = _dataSource[(NSUInteger) row][@"param"];
//    _ID = _dataSource[(NSUInteger) row][@"id"];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}



#pragma mark -- Button
- (void)cancleBtnClick
{
    [self hidePickerView];
}

- (void)sureBtnClick
{
    [self hidePickerView];
    if (self.houseTypePickViewBlock) {
        
        self.houseTypePickViewBlock(_room, _hall, _bath);
    }
//    if (self.selectedBlock != nil) {
//        self.selectedBlock(_name, _ID);
//    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickerView];
    }
}


#pragma mark -- lazy
- (UIButton *)cancleBtn
{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(10, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _cancleBtn.backgroundColor = [UIColor clearColor];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(self.frame.size.width - 60, 5, 50, BGHEIGHT - PICKERHEIGHT - 10);
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:CLBlueBtnColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sureBtn.backgroundColor = [UIColor clearColor];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

- (UIView *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, BGHEIGHT - PICKERHEIGHT)];
        _toolBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _toolBar;
}
- (UIView *)bgView  //主视图
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, BGHEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}


- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, BGHEIGHT - PICKERHEIGHT, self.frame.size.width, PICKERHEIGHT)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
