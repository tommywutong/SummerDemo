//
//  recommendVC.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendVC : UIViewController

@property(nonatomic, strong) UITabBarItem* leftbtn;
@property(nonatomic, strong) UITabBarItem* rightbtn;
@property(nonatomic, strong) UISearchBar* searchbar;
@property(nonatomic, strong) UITableView* tableview;

@end

NS_ASSUME_NONNULL_END
