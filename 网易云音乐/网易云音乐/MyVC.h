//
//  myVC.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import <UIKit/UIKit.h>
#import "ToolbarTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyVC : UIViewController<UITableViewDelegate, UITableViewDataSource, ToolbarTableViewCellDelegate>

@property(nonatomic, strong) UITabBarItem* leftbtn;
@property(nonatomic, strong) UITabBarItem* rightbtn;
@property(nonatomic, strong) UITabBarItem* midbtn;
@property(nonatomic, strong) UIImageView* avaterImageView;
@property(nonatomic, strong) UILabel* usernameLabel;
@property(nonatomic, strong) UILabel* vipLabel;
@property (nonatomic, strong) UILabel *mottoLabel;
@property (nonatomic, strong) UIView *tabBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *horizontalItems;



@end

NS_ASSUME_NONNULL_END
