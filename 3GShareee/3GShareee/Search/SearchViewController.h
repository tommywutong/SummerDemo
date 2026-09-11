//
//  SecondVC.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UIViewController<UISearchBarDelegate>

@property (nonatomic, strong)UISearchBar* searchBar;
@property (nonatomic, strong)UIImageView* Buttons1;
@property (nonatomic, strong)UIImageView* Buttons2;
@property (nonatomic, strong)UIImageView* Buttons3;
@end

NS_ASSUME_NONNULL_END
