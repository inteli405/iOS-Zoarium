//
//  Inteli405BookItemsViewController.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405BookItemsViewController.h"
#import "Inteli405BookItemStore.h"
#import "Inteli405Book.h"

@implementation Inteli405BookItemsViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        [[Inteli405BookItemStore sharedStore] createItem];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[[Inteli405BookItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[Inteli405BookItemStore sharedStore] allItems];
    Inteli405Book *item = items[indexPath.row];
    
    NSDateFormatter *datefom = [[NSDateFormatter alloc] init];
    [datefom setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [datefom stringFromDate:[item time]];
    
    cell.textLabel.text = [item bookName];
    cell.detailTextLabel.text = [[[item stateOfBookStr] stringByAppendingString:dateStr] stringByAppendingString:[item name]];
    return cell;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"书籍信息";
    [self setupRefresh];
}

-(void)task:(id)sender{
    NSTimer *localTimer = (NSTimer *)sender;
    NSLog(@"Schedule task has executed with this user info: %@", [localTimer userInfo]);
    [self.tableView reloadData];
}

-(void)setupRefresh
{
    //1.添加刷新控件
    UIRefreshControl *control=[[UIRefreshControl alloc]init];
    [control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:control];
    
}

-(void)refreshStateChange:(UIRefreshControl *)control {
    [[Inteli405BookItemStore sharedStore] createItem];
    [self.tableView reloadData];
    [control endRefreshing];
}

@end
