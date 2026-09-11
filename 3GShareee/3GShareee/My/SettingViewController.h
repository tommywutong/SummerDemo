//
//  SettingViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import <UIKit/UIKit.h>

#import "SettingViewController.h"
#import "BasicsViewController.h"
#import "ChangeKeyViewController.h"
#import "MessageSetViewController.h"
#import "MyMessageViewController.h"
#import "FollowViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : UIViewController
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray* settingsItems;


@end

NS_ASSUME_NONNULL_END
