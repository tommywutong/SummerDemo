//
//  SearchResultViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : UIViewController

@property (nonatomic, strong)UISearchBar* searchBar;
@property (nonatomic, strong)UITableView* tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

NS_ASSUME_NONNULL_END
