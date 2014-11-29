//
//  BTPactolaNotificationRequest.m
//  PactolaKit
//
//  Created by Thaddeus Ternes on 9/23/14.
//  Copyright (c) 2014 Bluetoo. All rights reserved.
//

#import "BTPactolaNotificationRequest.h"

@implementation BTPactolaNotificationRequest

- (void)dealloc
{
    self.deviceIdentifier = nil;
    self.title = nil;
    self.message = nil;
    self.url = nil;
    self.badgeCount = nil;
}

- (NSString *)requestMethod
{
    return @"POST";
}

- (NSString *)requestEndpoint
{
    return [NSString stringWithFormat:@"/%@/notification", self.deviceIdentifier];
}

- (NSData *)requestPayload
{
    NSMutableDictionary *json = [NSMutableDictionary dictionary];
    if(self.title)
        json[@"title"] = self.title;
    if(self.message)
        json[@"message"] = self.message;
    if(self.badgeCount)
        json[@"badge"] = self.badgeCount;
    if(self.url)
        json[@"url"] = self.url;
    
    NSError *serializationError = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:json options:0 error:&serializationError];
    
    if(serializationError != nil)
    {
        NSLog(@"**WARNING: Failed to serialize data: %@", serializationError);
        return nil;
    }
    
    if(data == nil)
    {
        NSLog(@"**WARNING: Serialization failed to produce data");
    }
    
    return data;
}

- (void)sendRequest
{
    NSAssert(self.deviceIdentifier, @"deviceIdentifier property must be set");
    [super sendRequest];
}

@end
