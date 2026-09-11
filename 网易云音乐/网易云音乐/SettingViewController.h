//
//  settingViewController.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/7/13.
//

#import <UIKit/UIKit.h>
#import "settingTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *backgroundDimmingView;
@property (nonatomic, assign) CGFloat drawerWidth;


@property (nonatomic, strong)UITableView* tableView;



@end

NS_ASSUME_NONNULL_END
