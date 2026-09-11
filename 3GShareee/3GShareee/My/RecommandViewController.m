//
//  tuijianViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "RecommandViewController.h"
#import "TextTableViewCell.h"

@interface RecommandViewController ()

@end

@implementation RecommandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"我的推荐";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 26];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"holidayfanhui.png"] style: UIBarButtonItemStylePlain target: self action: @selector(pressReturn)];
    self.navigationItem.leftBarButtonItem = btn;
    btn.tintColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
    
    [self setupData];
}


- (void)setupData {
    self.dataArray = [@[
        @{
            @"thumbnail": @"holiday",
            @"title": @"假日",
            @"author": @"小白",
            @"category": @"原创-插画-练习习作",
            @"time": @"15",
            @"isLiked": @NO,
            @"likeCount": @120
        },
        @{
            @"thumbnail": @"book",
            @"title": @"国外画册欣赏",
            @"author": @"小王",
            @"category": @"平面设计-画册设计",
            @"time": @"15",
            @"isLiked": @NO,
            @"likeCount": @120
        },
        @{
            @"thumbnail": @"flat",
            @"title": @"collection扁平设计",
            @"author": @"小吕",
            @"category": @"平面设计-海报设计",
            @"time": @"17",
            @"isLiked": @NO,
            @"likeCount": @120
        },
        @{
            @"thumbnail": @"layout",
            @"title": @"版式整理术：高效解决多风格要求",
            @"author": @"CHOICE",
            @"category": @"URSE TEAM | APOSTHON",
            @"time": @"32",
            @"isLiked": @NO,
            @"likeCount": @120
        }
    ] mutableCopy];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.itemIndex = indexPath.row;
    
    NSDictionary *item = self.dataArray[indexPath.row];
    
    [cell configureCellWithThumbnail:[UIImage imageNamed:item[@"thumbnail"]]
                                   title:item[@"title"]
                                  author:item[@"author"]
                                category:item[@"category"]
                                    time:item[@"time"]
                                 isLiked:[item[@"isLiked"] boolValue]
                           likeCount:[item[@"likeCount"] integerValue]];
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


- (void)pressReturn {
    [self.navigationController popViewControllerAnimated: YES];
}

//- (void)textTableViewCell:(textTableViewCell *)cell
//   didChangeLikeStatus:(BOOL)isLiked
//          newLikeCount:(NSInteger)likeCount
//{
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    if (indexPath.row < self.dataArray.count) {
//        NSMutableDictionary *item = self.dataArray[indexPath.row];
//        item[@"isLiked"] = @(isLiked);
//        item[@"likeCount"] = @(likeCount);
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
