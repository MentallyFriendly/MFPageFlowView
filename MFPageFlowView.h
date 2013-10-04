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

- (NSUInteger)numberOfPagesInFlowView:(MFPageFlowView*)flowView;

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

