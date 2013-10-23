//
// MFPageFlowView
// Mentally Friendly
//
// Created by Kyle Fuller on 24/09/2012.
// Copyright (c) 2012-2013 Mentally Friendly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFPageFlowView;

@protocol MFPageFlowViewDataSource <NSObject>

/** Asks the data source for the amount of views to display in the flow view
 * @param flowView The page flow view requesting this information
 * @return The number of views in the page flow view
 */
- (NSUInteger)numberOfPagesInFlowView:(MFPageFlowView*)flowView;

/** Asks the data source for the view to display in the flow view for an index
 * @param flowView The page flow view requesting this information
 * @return An object inheriting from UIView that the page flow view will use for this index. This must not be nil.
 */
- (UIView*)pageFlowView:(MFPageFlowView*)flowView
     viewForPageAtIndex:(NSUInteger)index;

@end

typedef NS_ENUM(NSUInteger, MFPageFlowViewLayoutOrientation) {
    MFPageFlowViewLayoutOrientationHorizontal,
    MFPageFlowViewLayoutOrientationVertical,
};

/** MFPageFlowView is a view which allows you to have a set of pages that you can swipe across.

This class can be used to make a view which can swipe over images.
 */

@interface MFPageFlowView : UIScrollView

@property (nonatomic, assign) MFPageFlowViewLayoutOrientation layoutOrientation;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, weak) IBOutlet id<MFPageFlowViewDataSource> dataSource;

/** Once set, MFPageFlowView will update the page control */
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

- (void)reloadData;

- (void)setCurrentPage:(NSUInteger)currentPage
              animated:(BOOL)animated;
@end

