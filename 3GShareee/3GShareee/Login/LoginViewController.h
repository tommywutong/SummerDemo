//
//  LoginViewController.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (nonatomic, strong)UIImageView* loginView;
@property (nonatomic, strong)UILabel* loginLabel;
@property (nonatomic, strong)UITextField* userName;
@property (nonatomic, strong)UITextField* passWord;
@property (nonatomic, strong)NSMutableArray* arrayUsername;
@property (nonatomic, strong)NSMutableArray* arrayPassword;
@property (nonatomic, strong)RegisterViewController* registerView;
@property (nonatomic, strong)UIAlertController* alertView;
@property (nonatomic, strong)UIButton* leftBtn;
@property (nonatomic, strong)UIButton* rightBtn;
@property (nonatomic, strong)UIButton* autoBtn;
@property (nonatomic, strong)UIButton* autoBtn1;
@property (strong, nonatomic) UIWindow * window;

@end

NS_ASSUME_NONNULL_END
