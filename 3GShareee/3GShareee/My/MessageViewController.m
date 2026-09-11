//
//  MessageViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/19.
//

#import "MessageViewController.h"
#import "ChatViewController.h"

@implementation Message

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"私信";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"私信";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    self.navigationItem.titleView = titleLabel;

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"holidayfanhui.png"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(backButtonTapped)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = backButton;

    [self createMyMessages];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 75, 0, 0);
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
}

- (void)createMyMessages {
    self.messages = [NSMutableArray array];
    NSArray *senders = @[@"share小格", @"share小兰", @"share小明", @"share小雪"];
    NSArray *contents = @[
        @"你的作品我很喜欢！",
        @"谢谢，已关注你",
        @"为你点赞！",
        @"你好可以问问你是怎么拍的吗？"
    ];
    NSArray *times = @[@"2分钟前", @"5分钟前", @"10分钟前", @"20分钟前"];
    NSArray *avatars = @[@"photo1.jpg", @"photo2.jpg", @"photo3.jpg", @"photo4.jpg"];
    
    for (int i = 0; i < senders.count; i++) {
        Message *message = [[Message alloc] init];
        message.senderName = senders[i];
        message.content = contents[i];
        message.avatarName = avatars[i];
        [self.messages addObject:message];
    }
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    Message *message = self.messages[indexPath.row];

    UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12, 50, 50)];
    avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarImageView.layer.cornerRadius = 4;
    avatarImageView.clipsToBounds = YES;
    avatarImageView.image = [UIImage imageNamed:message.avatarName];
    [cell.contentView addSubview:avatarImageView];

    UILabel *senderLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 12, 200, 20)];
    senderLabel.font = [UIFont boldSystemFontOfSize:16];
    senderLabel.textColor = [UIColor blackColor];
    senderLabel.text = message.senderName;
    [cell.contentView addSubview:senderLabel];

    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 35, self.view.frame.size.width - 90, 20)];
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.numberOfLines = 1;
    contentLabel.text = message.content;
    [cell.contentView addSubview:contentLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.messages[indexPath.row].isUnread = NO;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    ChatViewController *detailVC = [[ChatViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    //[self presentViewController:detailVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

@end
