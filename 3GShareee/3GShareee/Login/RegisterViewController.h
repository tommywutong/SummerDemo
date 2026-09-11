//
//  RegisterVC.h
//  3Gsharee
//
//  Created by 吴桐 on 2025/7/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RegisterVCDelegate <NSObject>

- (void)pushUser: (NSMutableArray *)arrayUserName andPassword: (NSMutableArray *)arrayPassWord;

@end

@interface RegisterViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) id<RegisterVCDelegate> delegate;
@property (nonatomic, strong)UIImageView* loginView;
@property (nonatomic, strong)UILabel* loginLabel;
@property (nonatomic, strong)UITextField* emailTextField;
@property (nonatomic, strong)UITextField* passwordTextField;
@property (nonatomic, strong)UITextField* usernameTextField;

//账号密码
@property (nonatomic, strong)NSMutableArray* arrayUsername;
@property (nonatomic, strong)NSMutableArray* arrayPassword;

@property (nonatomic, strong)UIButton* confirmBtn;
@end

NS_ASSUME_NONNULL_END
