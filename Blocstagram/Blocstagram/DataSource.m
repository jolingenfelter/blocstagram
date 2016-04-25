//
//  DataSource.m
//  Blocstagram
//
//  Created by Joanna Lingenfelter on 4/16/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Media.h"
#import "Comment.h"
#import "LoginViewController.h"

@interface DataSource () {
    
    NSMutableArray *_mediaItems;
}

@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSArray *mediaItems;

@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;

@end


@implementation DataSource

+(instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^ {
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self registerForAccessTokenNotification];
    }
    
    return self;
}

# pragma mark - Access Token

+ (NSString *) instagramClientID {
    
    return @"51b2d64d82084c58834555cbd2503052";
    
}

- (void) registerForAccessTokenNotification {
    
    [[NSNotificationCenter defaultCenter] addObserverForName:LoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        self.accessToken = note.object;
        
        [self populateDataWithParameters:nil];
    }];
}


#pragma mark - Key/Value Observing

- (NSUInteger) countOfMediaItems {
    
    return self.mediaItems.count;
    
}

- (id) objectInMediaItemsAtIndex:(NSUInteger)index {
    
    return [self.mediaItems objectAtIndex:index];
    
}

- (NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    
    return [self.mediaItems objectsAtIndexes: indexes];
}

- (void) insertObject:(Media *)object inMediaItemsAtIndex: (NSUInteger) index {
    
    [_mediaItems insertObject:object atIndex:index];
    
}

- (void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    
    [_mediaItems removeObjectAtIndex:index];
    
}

- (void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    
    [_mediaItems replaceObjectAtIndex:index withObject:object];
    
}

#pragma mark - Completion Handler

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    
   
    if (self.isRefreshing == NO) {
        self.isRefreshing = YES;
    
    
   // TODO: Add images
   
    
        self.isRefreshing = NO;
    
        if (completionHandler) {
            completionHandler(nil);
        
        }
        
    }
    
}

- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    
    if (self.isLoadingOlderItems == NO) {
        
        self.isLoadingOlderItems = YES;
        
        
        
        // TODO: Add images
            self.isLoadingOlderItems = NO;
        
            if (completionHandler) {
                completionHandler(nil);
            }
    
    }
}

- (void) deleteMediaItem:(Media *)item{
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];

    
}

- (void) populateDataWithParameters:(NSDictionary *)parameters {
    
    if (self.accessToken) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^ {
            
            NSMutableString *urlString = [NSMutableString stringWithFormat: @"https://api.instagram.com/v1/users/self/media/recent?access_token=%@", self.accessToken];
            
            for (NSString *parameterName in parameters) {
                
                [urlString appendFormat:@"&%@=%@", parameterName, parameters[parameterName]];
            }
            
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            if (url) {
                
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                NSURLResponse *response;
                NSError *webError;
    
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&webError];
                
                if(responseData) {
                    NSError *jsonError;
                    NSDictionary *feedDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                    
                    if (feedDictionary) {
                        dispatch_async(dispatch_get_main_queue(),^{
                            
                           [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
                        });
                    }
                }
            }
        });
    }
    
}

# pragma mark - Parsing Data

- (void) parseDataFromFeedDictionary:(NSDictionary *)feedDictionary fromRequestWithParameters:(NSDictionary *)parameters {
    
    NSArray *mediaArray = feedDictionary[@"data"];
    
    NSMutableArray *tmpMediaItems = [NSMutableArray array];
    
    for (NSDictionary *mediaDictionary in mediaArray) {
        
        Media *mediaItem = [[Media alloc] initWithDictionary:mediaDictionary];
        
        if (mediaItem) {
            [tmpMediaItems addObject:mediaItem];
            
            [self downloadImageForMediaItem:mediaItem];
        }
    }
    
    [self willChangeValueForKey:@"mediaItems"];
    self.mediaItems = tmpMediaItems;
    [self didChangeValueForKey:@"mediaItems"];
    
}

# pragma mark - Downloading Images

- (void) downloadImageForMediaItem:(Media *)mediaItem {
    
    if (mediaItem.mediaURL && !mediaItem.image) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSURLRequest *request = [NSURLRequest requestWithURL:mediaItem.mediaURL];
            
            NSURLResponse *response;
            NSError *error;
            NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            if (imageData) {
                
                UIImage *image = [UIImage imageWithData:imageData];
                
                if (image) {
                    
                    mediaItem.image = image;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
                        NSUInteger index = [mutableArrayWithKVO indexOfObject:mediaItem];
                        [mutableArrayWithKVO replaceObjectAtIndex:index withObject:mediaItem];
                        
                    });
                }
                
            } else {
                
                NSLog(@"Error downloading image: %@", error);
                
            }
        });
    }
}

















@end
