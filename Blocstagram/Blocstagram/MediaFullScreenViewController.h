//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 5/25/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *ImageView;

- (instancetype) initWithMedia: (Media *)media;

- (void) centerScrollView;
- (void) shareItem;

@end
