//
//  EventDetailSignVC.m
//  zhiyejia
//
//  Created by 谷治墙 on 2020/1/9.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "EventDetailSignVC.h"

#import "BorderTextField.h"

@interface EventDetailSignVC ()

@property (nonatomic, strong) BorderTextField *nameTF;

@property (nonatomic, strong) BorderTextField *phoneTF;

@property (nonatomic, strong) BorderTextField *cardTF;

@end

@implementation EventDetailSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}
    
- (void)initUI{
        
    NSArray *arr = @[@"姓名",@"联系电话",@"身份证"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, NAVIGATION_BAR_HEIGHT + 30 *SIZE + i * 50 *SIZE, 70 *SIZE, 14 *SIZE)];
        label.text = arr[i];
        label.adjustsFontSizeToFitWidth = YES;
        
        [self.view addSubview:label];
        
        BorderTextField *tf = [[BorderTextField alloc] initWithFrame:CGRectMake(80 *SIZE, NAVIGATION_BAR_HEIGHT + 23 *SIZE + i * 50 *SIZE, 258 *SIZE, 33 *SIZE)];
        if (i == 0) {
            
            _nameTF = tf;
            [self.view addSubview:_nameTF];
        }else if (i == 1){
            
            _phoneTF = tf;
            [self.view addSubview:_phoneTF];
        }else{
            
            _cardTF = tf;
            [self.view addSubview:_cardTF];
        }
    }
}

@end
