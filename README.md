# MFPageFlowView

A paging flow view, similar to the scrollable iOS App Store screenshots.

## Usage

MFPageFlowView is really simple to use, simply conform to the
MFPageFlowViewDataSource protocol and you can provide views for each "page".

You have to implement two methods, one for providing the amount of pages and
another for providing the page views.

```objective-c
@protocol MFPageFlowViewDataSource <NSObject>

- (NSUInteger)numberOfPagesInFlowView:(MFPageFlowView*)flowView;

- (UIView*)pageFlowView:(MFPageFlowView*)flowView
     viewForPageAtIndex:(NSUInteger)index;

@end
```

You can optionally set a page control and we will take care of maintaining the
count and selected pages.

```objective-c
typedef NS_ENUM(NSUInteger, MFPageFlowViewLayoutOrientation) {
    MFPageFlowViewLayoutOrientationHorizontal,
    MFPageFlowViewLayoutOrientationVertical,
};

@interface MFPageFlowView : UIScrollView

@property (nonatomic, assign) MFPageFlowViewLayoutOrientation
layoutOrientation;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, weak) IBOutlet id<MFPageFlowViewDataSource> dataSource;

/** Once set, MFPageFlowView will update the page control */
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

- (void)reloadData;

- (void)setCurrentPage:(NSUInteger)currentPage
              animated:(BOOL)animated;
@end
```

## License

MFPageFlowView is released under the MIT license. See [LICENSE](LICENSE).

