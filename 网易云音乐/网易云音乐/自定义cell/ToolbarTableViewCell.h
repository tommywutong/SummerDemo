//
//  ToolbarTableViewCell.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/20.
//

// ToolbarTableViewCell.h
#import <UIKit/UIKit.h>

@protocol ToolbarTableViewCellDelegate;

@interface ToolbarTableViewCell : UITableViewCell

@property (nonatomic, copy) NSArray<NSDictionary *> *menuItems;
@property (nonatomic, weak) id<ToolbarTableViewCellDelegate> delegate;

@end

@protocol ToolbarTableViewCellDelegate <NSObject>
- (void)toolbarCell:(ToolbarTableViewCell *)cell didSelectItemAtIndex:(NSInteger)index;
@end
