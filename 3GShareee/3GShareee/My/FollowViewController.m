//
//  followViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/19.
//

#import "FollowViewController.h"

@interface FollowViewController ()

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"关注列表";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;
    
    _users = @[@"小格", @"小兰", @"小明", @"小雪", @"萌萌", @"鹏涛"];
    _avatars = @[@"photo1.jpg", @"photo2.jpg", @"photo3.jpg", @"photo4.jpg", @"photo5.jpg", @"photo6.jpg"];
    _followingStatus = [NSMutableDictionary dictionary];

    for (NSString *username in _users) {
        _followingStatus[username] = @NO;
    }
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"FollowCell"];
    [self.view addSubview:self.tableView];
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowCell" forIndexPath:indexPath];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    NSString *username = self.users[indexPath.row];
    BOOL isFollowing = [self.followingStatus[username] boolValue];
    
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 40, 40)];
    avatarView.image = [UIImage imageNamed:self.avatars[indexPath.row]]; // 使用对应头像
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    avatarView.layer.cornerRadius = 20;
    avatarView.clipsToBounds = YES;
    [cell.contentView addSubview:avatarView];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 180, 25)];
    nameLabel.text = [NSString stringWithFormat:@"share %@", username];
    nameLabel.font = [UIFont systemFontOfSize:16];
    [cell.contentView addSubview:nameLabel];
    UIButton *followButton = [UIButton buttonWithType:UIButtonTypeSystem];
    followButton.frame = CGRectMake(tableView.frame.size.width - 95, 15, 80, 30);
    followButton.titleLabel.font = [UIFont systemFontOfSize:14];
    followButton.layer.cornerRadius = 4;
    followButton.layer.borderWidth = 1;
    followButton.tag = indexPath.row;
    if (isFollowing) {
        [followButton setBackgroundImage:[UIImage imageNamed:@"guanzhu_pressed"] forState:UIControlStateNormal];
        [followButton setTitle:@"" forState:UIControlStateNormal];
        followButton.layer.borderWidth = 0;
    } else {
        [followButton setBackgroundImage:[UIImage imageNamed:@"guanzhu_normal"] forState:UIControlStateNormal];
        [followButton setTitle:@"" forState:UIControlStateNormal];
        followButton.layer.borderWidth = 0;
    }
    
    [followButton addTarget:self action:@selector(followButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:followButton];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}
- (void)followButtonTapped:(UIButton *)sender {
    NSInteger index = sender.tag;
    NSString *username = self.users[index];
    BOOL currentStatus = [self.followingStatus[username] boolValue];
    self.followingStatus[username] = @(!currentStatus);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    /*
     通过tag找到被惦记的那一行
     然后对其BOOL取反，然后保存，刷新该行tableView
     */
}

@end
