//
//  MySubscibeVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MySubscibeVC.h"

#import "MySubscibeCell.h"

@interface MySubscibeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UITableView *table;

@end

@implementation MySubscibeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MySubscibeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MySubscibeCell"];
    if (!cell) {
        
        cell = [[MySubscibeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MySubscibeCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = @"新希望国际大厦";
    cell.statusL.text = @"在售";
    cell.addressL.text = @"高新区-天府三街-北街22号";
    cell.priceL.text = @"均价：16000元/m²";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    AppointSeeRoomVC *nextVC = [[AppointSeeRoomVC alloc] init];
//    [self.navigationController pushViewController:nextVC animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"取消收藏";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

- (void)initUI{
    
    self.titleLabel.text = @"我的订阅";
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 100 *SIZE;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = self.view.backgroundColor;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
