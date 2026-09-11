//
//  FirstVC.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import "HomeViewController.h"
#import "HomeViewControllerTableViewCell.h"
#import "TextTableViewCell.h"
#import "HolidayDetailTableViewCell.h"
#import "HolidayDetailViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, TextTableViewCellDelegate>
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"SHARE";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 26];
    self.navigationItem.titleView = titleLabel;
    self.scrollView = [[UIScrollView alloc] initWithFrame: self.view.bounds];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat estimatedHeight = screenWidth * 2;
    self.scrollView.contentSize = CGSizeMake(screenWidth, estimatedHeight);
    self.scrollView.scrollEnabled = YES;
    self.scrollView.pagingEnabled = NO;
    self.scrollView.backgroundColor = [UIColor colorWithDisplayP3Red: 234.0 / 255 green: 234.0 / 255 blue: 234.0 / 255 alpha: 234.0 / 255];
    CGRect tableFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 83);
    self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[HomeViewControllerTableViewCell class] forCellReuseIdentifier:@"advertise"];
    [self.tableView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollView addSubview: self.tableView];
    [self.view addSubview: self.scrollView];
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
            @"likeCount":@100
        },
        @{
            @"thumbnail": @"book",
            @"title": @"国外画册欣赏",
            @"author": @"小王",
            @"category": @"平面设计-画册设计",
            @"time": @"15",
            @"isLiked": @NO,
            @"likeCount":@100
        },
        @{
            @"thumbnail": @"flat",
            @"title": @"collection扁平设计",
            @"author": @"小吕",
            @"category": @"平面设计-海报设计",
            @"time": @"17",
            @"isLiked": @NO,
            @"likeCount":@100
        },
        @{
            @"thumbnail": @"layout",
            @"title": @"版式整理术：高效解决多风格要求",
            @"author": @"CHOICE",
            @"category": @"URSE TEAM | APOSTHON",
            @"time": @"32",
            @"isLiked": @NO,
            @"likeCount":@100
        }
    ] mutableCopy];
    
    NSDictionary *layoutItem = @{
        @"thumbnail": @"layout",
        @"title": @"版式整理术：高效解决多风格要求",
        @"author": @"CHOICE",
        @"category": @"URSE TEAM | APOSTHON",
        @"time": @"32",
        @"isLiked": @NO,
        @"likeCount":@100
    };
    
    for (int i = 0; i < 5; i++) {
        [self.dataArray addObject:layoutItem];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"advertise" forIndexPath:indexPath];
        return cell;
    }
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.itemIndex = indexPath.row;
    NSDictionary *item = self.dataArray[indexPath.row];
    UIImage *thumbnail = [UIImage imageNamed:item[@"thumbnail"]];
    NSString *title = item[@"title"];
    NSString *author = item[@"author"];
    NSString *category = item[@"category"];
    NSString *time = item[@"time"];
    BOOL isLiked = [item[@"isLiked"] boolValue];
    NSInteger likeCount = [item[@"likeCount"] integerValue];
    [cell configureCellWithThumbnail:thumbnail
                               title:title
                              author:author
                            category:category
                                time:time
                             isLiked:isLiked
                           likeCount:likeCount];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 1 : 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0) ? 200 : 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (section == 0) ? 0.1 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


- (void)textTableViewCellDidTap:(TextTableViewCell *)cell {
    // --------用于获取点击单元格的索引----------
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSMutableDictionary *holidayData = self.dataArray[0];
        HolidayDetailViewController *detailVC = [[HolidayDetailViewController alloc] init];
        detailVC.holidayData = [self.dataArray[0] mutableCopy];
        detailVC.delegate = self;
        detailVC.isLiked = [self.dataArray[0][@"isLiked"] boolValue];
        /*
         boolValue用于读取YES / NO
         在oc中，字典数组等职能存储对象（指针类型），不能储存基本数据类型，因此储存时候，将基本类型包装成NSNumber对象：
         BOOL isLiked = YES;
         NSNumber *numberObj = @(isLiked); // 或者 [NSNumber numberWithBool:isLiked]
         读取时，将NSNumber解包为基本类型：
         NSNumber *numberObj = data[@"isLiked"];
         BOOL isLiked = [numberObj boolValue];
        */
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)holidayDetail:(HolidayDetailViewController *)detail
  didChangeLikeStatus:(BOOL)isLiked
         newLikeCount:(NSInteger)likeCount
{
    NSMutableDictionary *item = [self.dataArray[0] mutableCopy];
    item[@"isLiked"] = @(isLiked);
    item[@"likeCount"] = @(likeCount);
    [self.dataArray replaceObjectAtIndex:0 withObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)textTableViewCell:(TextTableViewCell *)cell
   didChangeLikeStatus:(BOOL)isLiked
          newLikeCount:(NSInteger)likeCount
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.row >= self.dataArray.count) return;
    NSDictionary *originalItem = self.dataArray[indexPath.row];
    NSMutableDictionary *item = [originalItem mutableCopy];
    item[@"isLiked"] = @(isLiked);
    item[@"likeCount"] = @(likeCount);
    [self.dataArray replaceObjectAtIndex:indexPath.row withObject:item];
}
@end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
