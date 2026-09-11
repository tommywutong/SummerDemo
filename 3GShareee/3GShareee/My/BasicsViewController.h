//
//  basicsViewController.h
//  3GShareee
//
//  Created by 吴桐 on 2025/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicsViewController : UIViewController
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *signatureLabel;
@property (nonatomic, strong) UIButton *maleButton;
@property (nonatomic, strong) UIButton *femaleButton;
@property (nonatomic, strong) UILabel *emailLabel;

@end

NS_ASSUME_NONNULL_END
