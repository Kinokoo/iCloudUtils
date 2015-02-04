//
//  cloud.h
//  CloudTestApp
//
//  Created by Jani on 1/11/15.
//  Copyright (c) 2015 Janis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cloud : NSObject

+ (id) getCurrentiCloudToken;
+ (BOOL) saveiCloudPreferences: (id) currentiCloudToken;
+ (void) getiCloudContainer: (void(^)(NSURL *)) handler;
+ (NSUbiquitousKeyValueStore*) defaultStore;

@end
