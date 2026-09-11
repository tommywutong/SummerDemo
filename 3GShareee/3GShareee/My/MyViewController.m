//
//  FifthVC.m
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import "MyViewController.h"
#import "MenuCell.h"
#import "ArticleViewController.h"
#import "RecommandViewController.h"
#import "SettingViewController.h"
#import "BasicsViewController.h"
#import "MyMessageViewController.h"
@interface MyViewController ()

@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) SettingViewController* settingVC;
@property (nonatomic, strong) MyMessageViewController* messageVC;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];

    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    [_tableView registerClass:[MenuCell class] forCellReuseIdentifier:@"MenuCell"];

    UIView *headerView = [self createHeaderView];
    _tableView.tableHeaderView = headerView;
    _menuItems = @[
        @{@"title": @"我上传的", @"icon": [UIImage systemImageNamed:@"tray.and.arrow.up"]},
        @{@"title": @"我的信息", @"icon": [UIImage systemImageNamed:@"person.circle"]},
        @{@"title": @"我推荐的", @"icon": [UIImage systemImageNamed:@"hand.thumbsup"]},
        @{@"title": @"院系通知", @"icon": [UIImage systemImageNamed:@"bell"]},
        @{@"title": @"设置", @"icon": [UIImage systemImageNamed:@"gear"]}
    ];
//    UIView *footerView = [self createFooterView];
//    _tableView.tableFooterView = footerView;
    
    [self.view addSubview:_tableView];
}

- (UIView *)createHeaderView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    headerView.backgroundColor = [UIColor whiteColor];
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 49, 130, 130)];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImageView.clipsToBounds = YES;
    _avatarImageView.layer.cornerRadius = 0;
    _avatarImageView.layer.borderWidth = 2;
     UIImage *avatar = [UIImage imageNamed:@"headShot"];
    _avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarImageView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    
    _avatarImageView.image = avatar;
    [headerView addSubview:_avatarImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 50, self.view.bounds.size.width - 125, 25)];
    _nameLabel.text = @"share 小白";
    _nameLabel.font = [UIFont boldSystemFontOfSize:18];
    _nameLabel.textColor = [UIColor blackColor];
    [headerView addSubview:_nameLabel];
    
    _roleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 75, 200, 20)];
    _roleLabel.text = @"数媒/设计爱好者";
    _roleLabel.font = [UIFont systemFontOfSize:13];
    _roleLabel.textColor = [UIColor blackColor];
    [headerView addSubview:_roleLabel];
    
    _signatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, self.view.bounds.size.width - 40, 40)];
    _signatureLabel.text = @"开心了就笑，不开心了就待会儿再笑";
    _signatureLabel.font = [UIFont systemFontOfSize:12];
    _signatureLabel.textColor = [UIColor blackColor];
    _signatureLabel.numberOfLines = 0;
    [headerView addSubview:_signatureLabel];
    [self addStatsViewToHeader:headerView];
    
    return headerView;
}

- (void)addStatsViewToHeader:(UIView *)headerView {
    UIView *statsContainer = [[UIView alloc] initWithFrame:CGRectMake(150, 140, headerView.bounds.size.width - 40, 60)];
    [headerView addSubview:statsContainer];
    NSArray *statTitles = @[@"分享", @"喜欢", @"查看"];
    NSArray *statValues = @[@"15", @"120", @"66"];
    NSArray *statIcons = @[
        [UIImage imageNamed:@"img1"],
        [UIImage imageNamed:@"aixin"],
        [UIImage imageNamed:@"share_icon"]
    ];
    
    CGFloat statViewWidth = 80;
    for (int i = 0; i < 3; i++) {
        UIView *statView = [[UIView alloc] initWithFrame:CGRectMake(i * statViewWidth, 0, statViewWidth, 60)];
    
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((statViewWidth - 20) / 2, 10, 20, 20)];
        UIImage *iconImage = [statIcons[i] imageWithTintColor:[UIColor colorWithRed: 43.0 / 255 green: 123.0 / 255 blue: 191.0 / 255 alpha: 1.0]];
        icon.image = iconImage;
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame) + 5, statViewWidth, 20)];
        valueLabel.font = [UIFont boldSystemFontOfSize:12];
        valueLabel.textColor = [UIColor blackColor];
        valueLabel.text = statValues[i];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        [statView addSubview:icon];
        [statView addSubview:valueLabel];
        //[statView addSubview:titleLabel];
        [statsContainer addSubview:statView];
    }
}

- (UIView *)createFooterView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 80)];
    return footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    
    NSDictionary *item = self.menuItems[indexPath.row];

    UIImage *icon = [item[@"icon"] imageWithTintColor:[UIColor colorWithRed:0.1 green:0.5 blue:0.9 alpha:1.0]];
    [cell configureWithIcon:icon title:item[@"title"]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

/*
 设置和我的信息部分为了保证能保存之前更改过的性别等设置，做了特殊处理
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = self.menuItems[indexPath.row][@"title"];
    
    if ([title isEqualToString:@"我上传的"]) {
        ArticleViewController *uploadVC = [[ArticleViewController alloc] init];
        [self.navigationController pushViewController:uploadVC animated:YES];
    } else if ([title isEqualToString:@"我的信息"]) {
        [self showinfo];
    } else if ([title isEqualToString:@"我推荐的"]) {
        RecommandViewController *recommendVC = [[RecommandViewController alloc] init];
        recommendVC.view.backgroundColor = [UIColor whiteColor];
        recommendVC.title = @"我推荐的";
        [self.navigationController pushViewController:recommendVC animated:YES];
    } else if ([title isEqualToString:@"院系通知"]) {
        UIAlertController* boomAlert = [UIAlertController alertControllerWithTitle: @"提示" message: @"您目前没有通知" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction* boomAction = [UIAlertAction actionWithTitle: @"确定" style:UIAlertActionStyleDefault handler: nil];
        [boomAlert addAction: boomAction];
        [self presentViewController: boomAlert animated: YES completion: nil];
    } else {
        [self showsetting];
    }
}

-(void) showsetting {
    if (!_settingVC) {
        _settingVC = [[SettingViewController alloc] init];
        _settingVC.view.backgroundColor = [UIColor whiteColor];
        _settingVC.title = @"设置";
    }
    [self.navigationController pushViewController:_settingVC animated:YES];
}
-(void) showinfo {
    if (!_messageVC) {
        _messageVC = [[MyMessageViewController alloc] init];
        _messageVC.view.backgroundColor = [UIColor whiteColor];
        _messageVC.title = @"我的信息";
    }
    [self.navigationController pushViewController:_messageVC animated:YES];
}

- (void)logoutButtonTapped {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录"
                                                                   message:@"需求被驳回"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
   // [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
