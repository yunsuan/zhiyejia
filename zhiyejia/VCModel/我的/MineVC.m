//
//  MineVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2019/2/20.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "MineVC.h"

#import "LoginVC.h"
#import "PersonalVC.h"
#import "MyMessageVC.h"
#import "MyAppointVC.h"
#import "MySubscibeVC.h"
#import "FeedbackVC.h"
#import "MyAttentionAgentVC.h"


#import "MineHeader.h"
#import "MineCell.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray *_titleArr;
    NSArray *_imgArr;
}
@property (nonatomic, strong) UITableView *table;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDataSource];
    [self initUI];
}

- (void)initDataSource{
    
    _titleArr = @[@"个人资料",@"我的消息",@"我的预约",@"我的订阅",@"意见反馈",@"关于宜家"];
    _imgArr = @[@"personaldata",@"work",@"makeanappointment",@"subscribe",@"opinion",@"about"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    MineHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MineHeader"];
    if (!header) {
        
        header = [[MineHeader alloc] initWithReuseIdentifier:@"MineHeader"];
    }
    
    if ([UserModel defaultModel].token.length) {
        
        
    }else{
        
        header.headerImg.image = IMAGE_WITH_NAME(@"def_head");
        header.nameL.text = @"登录/注册";
    }
    
    header.mineHeaderNameBlock = ^{
        
        if ([UserModel defaultModel].token.length) {
            
            
        }else{
            
            [self.navigationController pushViewController:[[LoginVC alloc] init] animated:YES];
        }
    };
    
    header.mineHeaderImgBlock = ^{
      
        if ([UserModel defaultModel].token.length) {
            
            
        }else{
            
            
        }
    };
    
    header.mineHeaderRoomBtnBlock = ^{
        
    };
    
    header.mineHeaderAgentBtnBlock = ^{
      
        MyAttentionAgentVC *nextVC = [[MyAttentionAgentVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    header.mineHeaderHistoryBtnBlock = ^{
        
    };
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    if (!cell) {
        
        cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleL.text = _titleArr[indexPath.row];
    cell.titleImg.image = IMAGE_WITH_NAME(_imgArr[indexPath.row]);
    cell.rightImg.image = IMAGE_WITH_NAME(@"rightarrow");
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
            PersonalVC *nextVC = [[PersonalVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
            
        case 1:{
            
            MyMessageVC *nextVC = [[MyMessageVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 2:{
            
            MyAppointVC *nextVC = [[MyAppointVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 3:{
            
            MySubscibeVC *nextVC = [[MySubscibeVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        case 4:{
            
            FeedbackVC *nextVC = [[FeedbackVC alloc] init];
            [self.navigationController pushViewController:nextVC animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)initUI{
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - TAB_BAR_HEIGHT) style:UITableViewStylePlain];
    _table.bounces = NO;
    _table.rowHeight = UITableViewAutomaticDimension;
    _table.estimatedRowHeight = 40 *SIZE;
    _table.sectionHeaderHeight = UITableViewAutomaticDimension;
    _table.estimatedSectionHeaderHeight = 220 *SIZE;
    _table.backgroundColor = CLWhiteColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [self.view addSubview:_table];
}

@end
