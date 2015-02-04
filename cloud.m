//
//  cloud.m
//  CloudTestApp
//
//  Created by Jani on 1/11/15.
//  Copyright (c) 2015 Janis. All rights reserved.
//

#import "cloud.h"

@implementation cloud

+ (id) getCurrentiCloudToken
{
    NSFileManager* fileManager = [NSFileManager defaultManager];

    return(fileManager.ubiquityIdentityToken);
}

+ (BOOL) saveiCloudPreferences: (id) currentiCloudToken
{
    NSString* appID   = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString* appKey  = [NSString stringWithFormat:@"%@.UbiquityIdentityToken", appID];

    if (currentiCloudToken) {
        NSData *newTokenData = [NSKeyedArchiver archivedDataWithRootObject: currentiCloudToken];
        [[NSUserDefaults standardUserDefaults] setObject: newTokenData
                                                  forKey: appKey];
        return YES;
    } else {
        [[NSUserDefaults standardUserDefaults]
         removeObjectForKey: appKey];
        return NO;
    }
}

+ (void) getiCloudContainer: (void(^)(NSURL *)) handler
{
    __block NSURL * myContainer;
    dispatch_async (dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
    {
        myContainer = [[NSFileManager defaultManager]
                       URLForUbiquityContainerIdentifier: nil];

        if (myContainer != nil)
        {
            dispatch_async (dispatch_get_main_queue(), ^(void)
            { handler(myContainer); });
        }
    });
}

+ (NSUbiquitousKeyValueStore*) defaultStore
{
    return [NSUbiquitousKeyValueStore defaultStore];
}

@end
