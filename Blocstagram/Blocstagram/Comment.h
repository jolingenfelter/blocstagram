//
//  Comment.h
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Comment : NSObject

@property (nonatomic, strong) NSString *idNumber;

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;


- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;

@end
