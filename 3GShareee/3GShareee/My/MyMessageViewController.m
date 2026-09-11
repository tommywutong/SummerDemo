//
//  myMessageViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "MyMessageViewController.h"
#import "ChatViewController.h"
#import "FollowViewController.h"
#import "MessageViewController.h"

@interface MyMessageViewController ()
@property(nonatomic, strong) UITableView* tableView;
@property(nonatomic, strong) NSArray* messageTypes;
@property(nonatomic, strong) NSArray* unreadCounts;

// 添加对 followViewController 的强引用，确保只创建一次
@property (nonatomic, strong) FollowViewController *followVC;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息设置";
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"消息设置";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    self.navigationItem.titleView = titleLabel;

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTapped)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
    self.messageTypes = @[@"评论", @"我的推荐", @"新关注的", @"私信", @"活动通知"];
    self.unreadCounts = @[@7, @9, @5, @4, @1];
    
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MessageCell"];
    
    [self.view addSubview:self.tableView];
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
//    for (UIView *subview in cell.contentView.subviews) {
//        [subview removeFromSuperview];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, cell.contentView.frame.size.height)];
    titleLabel.text = self.messageTypes[indexPath.row];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [cell.contentView addSubview:titleLabel];
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"chevron.right"]];
    arrowView.tintColor = [UIColor lightGrayColor];
    arrowView.frame = CGRectMake(tableView.frame.size.width - 30,
                                 (cell.contentView.frame.size.height - 20) / 2,
                                 15,
                                 20);
    [cell.contentView addSubview:arrowView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *messageType = self.messageTypes[indexPath.row];
    if ([messageType isEqualToString:@"私信"]) {
        MessageViewController *detailVC = [[MessageViewController alloc] init];
        detailVC.title = messageType;
        [self.navigationController pushViewController:detailVC animated:YES];
    } else if ([messageType isEqualToString:@"新关注的"]) {
        // 使用强引用确保只创建一次 followViewController
        if (!_followVC) {
            _followVC = [[FollowViewController alloc] init];
            _followVC.title = @"关注列表";
            _followVC.view.backgroundColor = [UIColor whiteColor];
        }
        [self.navigationController pushViewController:_followVC animated:YES];
    } else {
        /*
         弹出一个提示框，显示没有新内容
         同时用了一个淡出动画，这个属于难一些的动画，我也不太了解
         */
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"没有新内容" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alert dismissViewControllerAnimated:YES completion:nil];
        });
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
