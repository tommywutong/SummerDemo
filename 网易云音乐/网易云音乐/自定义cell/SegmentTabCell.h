//
//  SegmentTabCell.h
//  网易云音乐
//
//  Created by 吴桐 on 2025/6/20.
//

// SegmentTabCell.h
#import <UIKit/UIKit.h>

@class SegmentTabCell;

@protocol SegmentTabCellDelegate <NSObject>
- (void)segmentTabCell:(SegmentTabCell *)cell didSelectSegmentAtIndex:(NSInteger)index;
@end

@interface SegmentTabCell : UITableViewCell

@property (weak, nonatomic) id<SegmentTabCellDelegate> delegate;
@property (nonatomic, strong) NSArray *segmentTitles;
@property (nonatomic, assign) NSInteger selectedIndex;

// 内容数据
@property (nonatomic, strong) NSArray *musicContent;
@property (nonatomic, strong) NSArray *podcastContent;
@property (nonatomic, strong) NSArray *noteContent;

@end
