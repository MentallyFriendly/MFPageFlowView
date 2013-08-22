//
// MFPageFlowView
// Mentally Friendly
//
// Created by Kyle Fuller on 24/09/2012.
// Copyright (c) 2012 Mentally Friendly. All rights reserved.
//

#import "MFPageFlowView.h"

@interface MFPageFlowView ()

@property (nonatomic, assign) CGSize lastSize;
@property (nonatomic, strong) NSArray *pages;

@end

@implementation MFPageFlowView

- (id)init {
    if (self = [super init]) {
        [self setupDefaults];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupDefaults];
    }

    return self;
}

- (void)setupDefaults {
    _currentPage = 0;

    [self setPagingEnabled:YES];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setClipsToBounds:YES];
    [self setScrollsToTop:NO];
}

- (void)reloadData {
    [[self pages] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSUInteger numberOfPages = [[self dataSource] numberOfPagesInFlowView:self];
    NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:numberOfPages];

    for (NSUInteger index = 0; index < numberOfPages; index++) {
        UIView *view = [[self dataSource] pageFlowView:self viewForPageAtIndex:index];
        [view setClipsToBounds:YES];

        [self addSubview:view];
        [pages addObject:view];
    }

    [self setPages:pages];

    [self updateContentSize];
    [[self pageControl] setNumberOfPages:(NSInteger)numberOfPages];
}

#pragma mark - Setters

- (void)setCurrentPage:(NSUInteger)currentPage {
    [self setCurrentPage:currentPage
                animated:NO];
}

- (void)setCurrentPage:(NSUInteger)currentPage
              animated:(BOOL)animated {
    CGRect frame = [self frame];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat x = (width * currentPage);
    
    [self setContentOffset:CGPointMake(x, 0)
                  animated:animated];
}

- (void)setPageControl:(UIPageControl *)pageControl {
    [[self pageControl] removeTarget:self
                              action:@selector(pageControlDidChange:)
                    forControlEvents:UIControlEventValueChanged];

    _pageControl = pageControl;

    [[self pageControl] addTarget:self
                           action:@selector(pageControlDidChange:)
                 forControlEvents:UIControlEventValueChanged];

    NSUInteger numberOfPages = [[self dataSource] numberOfPagesInFlowView:self];
    [[self pageControl] setNumberOfPages:(NSInteger)numberOfPages];
}

- (void)setDataSource:(id<MFPageFlowViewDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

- (void)updateContentSize {
    NSUInteger numberOfPages = [[self dataSource] numberOfPagesInFlowView:self];

    CGRect frame = [self frame];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);

    [self setContentSize:CGSizeMake(width * numberOfPages, height)];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGRect frame = [self frame];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);

    NSUInteger page = 0;
    for (UIView *view in [self pages]) {
        if ([self layoutOrientation] == MFPageFlowViewLayoutOrientationHorizontal) {
            [view setFrame:CGRectMake(width * page, 0, width, height)];
        } else {
            [view setFrame:CGRectMake(0, width * page, width, height)];
        }

        ++page;
    }

    [self updateContentSize];

    // Make sure that we are on a page.
    CGSize lastSize = [self lastSize];
    if (CGSizeEqualToSize(lastSize, frame.size) == NO) {
        [self setCurrentPage:_currentPage];
    }

    [self setLastSize:frame.size];
}

- (void)pageControlDidChange:(UIPageControl*)pageControl {
    NSInteger page = [pageControl currentPage];

    CGRect frame = [self frame];
    CGFloat width = CGRectGetWidth(frame);
    CGFloat height = CGRectGetHeight(frame);

    CGRect scrollFrame;

    switch ([self layoutOrientation]) {
        case MFPageFlowViewLayoutOrientationHorizontal: {
            scrollFrame = CGRectMake(width * page, 0, width, height);
            break;
        }

        case MFPageFlowViewLayoutOrientationVertical: {
            scrollFrame = CGRectMake(0, width * page, width, height);
            break;
        }
    }

    [self scrollRectToVisible:scrollFrame animated:YES];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    [super setContentOffset:contentOffset];

    CGRect frame = [self frame];

    NSUInteger currentPage;

    switch ([self layoutOrientation]) {
        case MFPageFlowViewLayoutOrientationHorizontal: {
            CGFloat pageWidth = CGRectGetWidth(frame);
            currentPage = lroundf(floorf((contentOffset.x - (pageWidth / 2.0f)) / pageWidth) + 1.0f);
            break;
        }

        case MFPageFlowViewLayoutOrientationVertical: {
            CGFloat pageHeight = CGRectGetHeight(frame);
            currentPage = lroundf(floorf((contentOffset.y - (pageHeight / 2.0f)) / pageHeight) + 1.0f);
            break;
        }
    }

    if (_currentPage != currentPage) {
        [[self pageControl] setCurrentPage:currentPage];

        if (currentPage <= [[self dataSource] numberOfPagesInFlowView:self]) {
            _currentPage = currentPage;
        }
    }
}

@end
