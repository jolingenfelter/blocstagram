//
//  FilterViewCell.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 6/7/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "FilterViewCell.h"

@interface FilterViewCell ()

@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UILabel *filterTitleLabel;

@end

@implementation FilterViewCell

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.thumbnail = [[UIImageView alloc] init];
        self.filterTitleLabel = [[UILabel alloc] init];
        
        self.backgroundColor = [UIColor whiteColor];
        self.thumbnail.backgroundColor = [UIColor whiteColor];
        self.thumbnail.clipsToBounds = YES;
        self.thumbnail.contentMode = UIViewContentModeScaleAspectFill;
        
        self.filterTitleLabel.backgroundColor = [UIColor whiteColor];
        self.filterTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.filterTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:10];
        
        [self.contentView addSubview:self.thumbnail];
        [self.contentView addSubview:self.filterTitleLabel];
    }
    
    return self;
}

- (void) layoutSubviews {
    
    CGFloat width = CGRectGetWidth(self.contentView.frame);
    self.thumbnail.frame = CGRectMake(0, 0, width, width);
    self.filterTitleLabel.frame = CGRectMake(0, 0, width, 20);
}

- (void) setFilterName:(NSString *)filterName {
    _filterName = filterName;
    self.filterTitleLabel.text = filterName;
}

- (void) setFilteredImage:(UIImage *)filteredImage {
    _filteredImage = filteredImage;
    self.thumbnail.image = filteredImage;
}

@end
