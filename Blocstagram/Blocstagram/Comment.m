//
//  Comment.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary {
    
    self = [super init];
    
    if (self) {
        
        self.idNumber = commentDictionary[@"id"];
        self.text = commentDictionary[@"text"];
        self.from = [[User alloc] initWithDictionary:commentDictionary[@"from"]];
    }
    
    return self;
    
}

@end
