//
//  FilterViewCell.h
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 6/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViweCell;

@interface FilterViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *filterName;
@property (nonatomic, strong) UIImage *filteredImage;

@end
