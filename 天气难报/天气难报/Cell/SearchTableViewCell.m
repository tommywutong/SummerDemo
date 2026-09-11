//
//  SearchTableViewCell.m
//  天气难报
//
//  Created by 吴桐 on 2025/7/23.
//
#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:18];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        /*
         给 UITableViewCell 添加一个 右边的小箭头 点击这个单元格可以进入下一级页面

         常见的几种accessoryType类型：
            UITableViewCellAccessoryNone  默认，没有额外的标记
            UITableViewCellAccessoryDisclosureIndicator 一个箭头，可以跳转
            UITableViewCellAccessoryDetailDisclosureButton 一个圆圈加箭头 用于附带详细信息
            UITableViewCellAccessoryCheckmark  一个对勾，用于选中状态
            UITableViewCellAccessoryDetailButton 一个小圆圈 ( i )显示附加信息
         */
    }
    return self;
}

@end
