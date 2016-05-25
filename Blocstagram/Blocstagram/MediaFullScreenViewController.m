//
//  MediaFullScreenViewController.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 5/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "MediaFullScreenViewController.h"
#import "Media.h"

@interface MediaFullScreenViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) Media *media;

@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) UITapGestureRecognizer *doubleTap;

@end

@implementation MediaFullScreenViewController

- (instancetype) initWithMedia:(Media *)media {
    self = [super init];
    
    if (self) {
        self.media = media;
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    //#1
    self.scrollView = [UIScrollView new];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    
    //#2
    self.ImageView = [UIImageView new];
    self.ImageView.image = self.media.image;
    
    [self.scrollView addSubview:self.ImageView];
    
    //#3
    self.scrollView.contentSize = self.media.image.size;
    
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
    self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapFired:)];
    self.doubleTap.numberOfTapsRequired = 2;
    
    [self.tap requireGestureRecognizerToFail:self.doubleTap];
    
    [self.scrollView addGestureRecognizer:self.tap];
    [self.scrollView addGestureRecognizer:self.doubleTap];
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    //#4
    self.scrollView.frame = self.view.bounds;
    
    //#5
    CGSize scrollViewFrameSize = self.scrollView.frame.size;
    CGSize scrollViewContentSize = self.scrollView.contentSize;
    
    CGFloat scaleWidth = scrollViewFrameSize.width / scrollViewContentSize.width;
    CGFloat scaleHeight = scrollViewFrameSize.height / scrollViewContentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1;
}

- (void) centerScrollView {
    [self.ImageView sizeToFit];
    
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.ImageView.frame;
    
    if (contentsFrame.size.width < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - CGRectGetHeight(contentsFrame)) /2;
    } else {
        contentsFrame.origin.y = 0;
    }
    
    self.ImageView.frame = contentsFrame;
}

# pragma mark - UIScrollViewDelegate

//#6
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.ImageView;
}

//#7
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self centerScrollView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self centerScrollView];
}

# pragma mark - Gesture Recognizers

- (void) tapFired:(UITapGestureRecognizer *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) doubleTapFired:(UITapGestureRecognizer *) sender {
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        
        //#8
        CGPoint locationPoint = [sender locationInView:self.ImageView];
        
        CGSize scrollViewSize = self.scrollView.bounds.size;
        
        CGFloat width = scrollViewSize.width / self.scrollView.maximumZoomScale;
        CGFloat height = scrollViewSize.height / self.scrollView.maximumZoomScale;
        CGFloat x = locationPoint.x - (width/2);
        CGFloat y = locationPoint.y - (height/2);
        
        [self.scrollView zoomToRect:CGRectMake(x, y, width, height) animated:YES];
        
    } else {
        //#9
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    }
}
















































@end
