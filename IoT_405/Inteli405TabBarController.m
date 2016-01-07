//
//  Inteli405TabBarController.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405TabBarController.h"
#import "Inteli405SummaryViewController.h"
#import "Inteli405BookItemsViewController.h"
#import "Inteli405ReaderViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
CGFloat const tabViewHeight = 49;
CGFloat const buttonWidth = 64;
CGFloat const buttonHeight = 45;

@interface Inteli405TabBarController ()

@end

@implementation Inteli405TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self initTabBarViewController];
    [self initTabBarView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTabBarViewController {
    Inteli405SummaryViewController *summaryVC = [[Inteli405SummaryViewController alloc] init];
    Inteli405BookItemsViewController *bookVC = [[Inteli405BookItemsViewController alloc] init];
    Inteli405ReaderViewController *readerVC = [[Inteli405ReaderViewController alloc] init];
    
    NSArray *VC_Array = @[summaryVC, bookVC, readerVC];
    NSMutableArray *tabArray = [NSMutableArray arrayWithCapacity:VC_Array.count];
    for (int i = 0; i<VC_Array.count; i++) {
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:VC_Array[i]];
        [tabArray addObject:nvc];
    }
    self.viewControllers = tabArray;
}

-(void)initTabBarView{
    //初始化标签工具栏视图
    _tabBarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-tabViewHeight, ScreenWidth, tabViewHeight)];
    _tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBarView];
    NSArray *imgArray = @[@"Summary.jpg",@"Book.png",@"Reader.png"];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:imgArray[i]] forState:UIControlStateNormal];
        btn.frame = CGRectMake((32+buttonWidth)*i+32, tabViewHeight-buttonHeight, buttonWidth, buttonHeight);
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBarView addSubview:btn];
    }
    
}

-(void)btnClicked:(UIButton *)button{
    self.selectedIndex = button.tag-100;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
