//
//  PlusViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/17.
//

#import <UIKit/UIKit.h>
#import "PhotoWallViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlusViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton* choosePhoto;
@property (nonatomic, strong)UIImageView* navigationIcon;
@property (nonatomic, strong)UIButton* locationButton;
@property NSMutableArray* cellArray;
@property (nonatomic, strong)UIButton* foldButton;
@property (nonatomic, strong)UITableView* foldTableView;
@property (nonatomic, strong)UITextField* nameTextField;
@property (nonatomic, strong)UITextField* describeTextField;
@property (nonatomic, assign) int numbersOfPhoto;

@end

NS_ASSUME_NONNULL_END
