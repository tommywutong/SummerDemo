//
//  AddViewController.h
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray* tempData;
@property (nonatomic, strong)NSMutableArray* cityData;
@property (nonatomic, strong)NSMutableArray* weatherimgData;
@property (nonatomic, strong)NSArray* searchResults;
@property (nonatomic, strong)UITextField* searchBar;
@property (nonatomic, strong)UITableView* tableView;
@end

NS_ASSUME_NONNULL_END
