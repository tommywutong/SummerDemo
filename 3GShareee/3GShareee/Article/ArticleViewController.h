//
//  ThirdVC.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArticleViewController : UIViewController
@property (nonatomic, strong)UIScrollView* scrollView;
@property (nonatomic, strong)UISegmentedControl* segmented;
@property (nonatomic, strong)UITableView* tableView01;
@property (nonatomic, strong)UITableView* tableView02;
@property (nonatomic, strong)UITableView* tableView03;
@end

NS_ASSUME_NONNULL_END
