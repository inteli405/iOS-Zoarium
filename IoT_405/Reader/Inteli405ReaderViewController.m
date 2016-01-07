//
//  Inteli405ReaderViewController.m
//  IoT_405
//
//  Created by Zhang Junkai on 16/1/6.
//  Copyright © 2016年 Zhang Junkai. All rights reserved.
//

#import "Inteli405ReaderViewController.h"
#import "Inteli405ReaderItemStore.h"
#import "Inteli405Reader.h"

@interface Inteli405ReaderViewController ()

@end

@implementation Inteli405ReaderViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        for (int i=0; i<20; i++) {
            [[Inteli405ReaderItemStore sharedStore] createItem];
        }
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[[Inteli405ReaderItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSArray *items = [[Inteli405ReaderItemStore sharedStore] allItems];
    Inteli405Reader *item = items[indexPath.row];
    
    cell.textLabel.text = [item readerName];
    cell.detailTextLabel.text = [item stateOfReaderStr];
    //[cell.contentView addSubview:[UIImage imageNamed:@"BOOK_LENT.png"]];
    //cell.imageView = [UIImage imageNamed:@"BOOK_LENT.png"];
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"405成员";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
