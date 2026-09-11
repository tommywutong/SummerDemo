//
//  ToolbarTableViewCell.m
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/20.
//

#import "ToolbarTableViewCell.h"

@interface ToolbarTableViewCell ()
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@property (nonatomic, strong) NSMutableArray<UIView *> *backgroundViews; // 每个按钮的背景视图
@end

@implementation ToolbarTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor clearColor];

    _buttons = [NSMutableArray array];
    _backgroundViews = [NSMutableArray array];

    for (int i = 0; i < 5; i++) {
        UIView *backgroundView = [[UIView alloc] init];
        backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        backgroundView.layer.cornerRadius = 10;
        [self.contentView addSubview:backgroundView];
        [_backgroundViews addObject:backgroundView];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.titleLabel.minimumScaleFactor = 0.8;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:button];
        [_buttons addObject:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15.0;
    CGFloat buttonSpacing = 5.0; 
    CGFloat contentWidth = CGRectGetWidth(self.contentView.bounds) - padding * 2;
    CGFloat contentHeight = 40.0;
    
    CGFloat buttonWidth = (contentWidth - (4 * buttonSpacing)) / _buttons.count;
 
    for (int i = 0; i < _buttons.count; i++) {
        CGFloat xPosition = padding + i * (buttonWidth + buttonSpacing);
        

        UIView *backgroundView = _backgroundViews[i];
        backgroundView.frame = CGRectMake(xPosition, -30, buttonWidth, contentHeight);
        
        UIButton *button = _buttons[i];
        button.frame = CGRectMake(xPosition, -30, buttonWidth, contentHeight);
    
        [self layoutButtonContent:button];
    }
}

- (void)layoutButtonContent:(UIButton *)button {
    button.imageView.transform = CGAffineTransformIdentity;
    button.titleLabel.transform = CGAffineTransformIdentity;
    
    CGFloat targetIconSize = 25.0;

    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    button.imageView.frame = CGRectMake((button.bounds.size.width - targetIconSize) / 2,
                                       10, // 增加上边距
                                       targetIconSize,
                                       targetIconSize);

    button.titleLabel.frame = CGRectMake(0,
                                       button.bounds.size.height - 20, // 下移文本
                                       button.bounds.size.width,
                                       15);
}

- (void)setMenuItems:(NSArray<NSDictionary *> *)menuItems {
    _menuItems = menuItems;
    [self updateButtons];
}

- (void)updateButtons {
    for (int i = 0; i < MIN(_menuItems.count, _buttons.count); i++) {
        NSDictionary *item = _menuItems[i];
        UIButton *button = _buttons[i];
        

        [button setTitle:item[@"title"] forState:UIControlStateNormal];
        
        UIImage *icon = [UIImage imageNamed:item[@"icon"]];
        [button setImage:icon forState:UIControlStateNormal];
        
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        button.tintColor = nil;
        button.imageView.tintColor = nil;

        if (i == 0) {
            [button setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];

            UIView *backgroundView = _backgroundViews[i];
            backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        } else {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.tintColor = [UIColor whiteColor];
            UIView *backgroundView = _backgroundViews[i];
            backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        }
    }
    [self setNeedsLayout];
}

- (void)buttonTapped:(UIButton *)sender {
    NSInteger index = sender.tag;
    
    for (int i = 0; i < _buttons.count; i++) {
        UIButton *button = _buttons[i];
        UIView *backgroundView = _backgroundViews[i];
        BOOL selected = (i == index);
        
        if (selected) {
            [button setTitleColor:[UIColor colorWithRed:0.18 green:0.80 blue:0.98 alpha:1.0]
                         forState:UIControlStateNormal];
            backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
        } else {
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            backgroundView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
        }
    }
    
    // 通知代理
//    if ([self.delegate respondsToSelector:@selector(toolbarCell:didSelectItemAtIndex:)]) {
//        [self.delegate toolbarCell:self didSelectItemAtIndex:index];

}

@end
