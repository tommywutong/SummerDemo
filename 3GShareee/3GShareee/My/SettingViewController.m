//
//  SettingViewController.m
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import "SettingViewController.h"
#import "BasicsViewController.h"
#import "ChangeKeyViewController.h"
#import "MessageSetViewController.h"
#import "MyMessageViewController.h"

@interface SettingViewController ()
@property (nonatomic, strong) BasicsViewController *basicsVC;
@property (nonatomic, strong) ChangeKeyViewController *changeKeyVC;
@property (nonatomic, strong) MessageSetViewController *messageSetVC;
@property (nonatomic, strong) FollowViewController *followVC;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"设置";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize: 26];
    self.navigationItem.titleView = titleLabel;
    
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"holidayfanhui.png"] style: UIBarButtonItemStylePlain target: self action: @selector(pressReturn)];
    self.navigationItem.leftBarButtonItem = btn;
    btn.tintColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:_tableView];

    _settingsItems = @[
        @{@"title": @"基本资料"},
        @{@"title": @"修改密码"},
        @{@"title": @"消息设置"},
        @{@"title": @"关于 SHARE"},
        @{@"title": @"清除缓存"}
    ];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SettingCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    
    NSDictionary *item = self.settingsItems[indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectedItem = self.settingsItems[indexPath.row][@"title"];
    if ([selectedItem isEqualToString:@"基本资料"]) {
        [self showBasicInfo];
    } else if ([selectedItem isEqualToString:@"修改密码"]) {
        [self showChangePassword];
    } else if ([selectedItem isEqualToString:@"消息设置"]) {
        [self showNotificationSettings];
    } else if ([selectedItem isEqualToString:@"关于 SHARE"]) {
        [self showAboutShare];
    } else if ([selectedItem isEqualToString:@"清除缓存"]) {
        [self clearCache];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    return headerView;
}

- (void)showBasicInfo {
    if (!_basicsVC) {
        _basicsVC = [[BasicsViewController alloc] init];
        _basicsVC.view.backgroundColor = [UIColor whiteColor];
    }
    [self.navigationController pushViewController:_basicsVC animated:YES];
}

- (void)showChangePassword {
    if (!_changeKeyVC) {
            _changeKeyVC = [[ChangeKeyViewController alloc] init];
            _changeKeyVC.title = @"修改密码";
            _changeKeyVC.view.backgroundColor = [UIColor whiteColor];
        }
        [self.navigationController pushViewController:_changeKeyVC animated:YES];
}

- (void)showNotificationSettings {
    if (!_messageSetVC) {
        _messageSetVC = [[MessageSetViewController alloc] init];
        _messageSetVC.title = @"消息设置";
        _messageSetVC.view.backgroundColor = [UIColor whiteColor];
    }
    [self.navigationController pushViewController:_messageSetVC animated:YES];
}

- (void)showAboutShare {
    UIViewController *aboutVC = [[UIViewController alloc] init];
    aboutVC.title = @"关于 SHARE";
    aboutVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:aboutVC animated:YES];
}

- (void)clearCache {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存"
                                                                   message:@"确定要清除所有缓存数据吗？"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self showClearCacheSuccess];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)showClearCacheSuccess {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"缓存已清除"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    /*
     使用NSTimer定时两秒，或者可以用performSelector:withObject:afterDelay:
     如：
     [self performSelector:@selector(dismissViewControllerAnimated:)
     withObject:@(YES)
     afterDelay:2.0];
     
     */
    [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void) pressReturn {
    [self.navigationController popViewControllerAnimated: YES];
}

@end
