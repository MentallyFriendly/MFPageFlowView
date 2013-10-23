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

## Installation

[CocoaPods](http://cocoapods.org) is the recommended way to add
MFPageFlowView to your project.

Here's an example podfile that installs MFPageFlowView.

```ruby
platform :ios, '5.0'

pod 'MFPageFlowView'
```

Note the specification of iOS 5.0 as the platform; leaving out the 5.0 will
cause CocoaPods to fail with the following message:

> [!] MFPageFlowView is not compatible with iOS 4.3.

## Documentation

There is full documentation for MFPageFlowView, it can either be found on
[CocoaDocs](http://cocoadocs.org/docsets/MFPageFlowView) or within the headers of
MFPageFlowView.

## License

MFPageFlowView is released under the MIT license. See [LICENSE](LICENSE).

