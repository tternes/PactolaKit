//
//  BTPactolaRequest.m
//  Pactola
//
//  Created by Thaddeus Ternes on 8/21/14.
//  Copyright (c) 2014 Bluetoo. All rights reserved.
//

#import "BTPactolaRequest.h"

@interface BTPactolaRequest ()
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, assign) NSUInteger statusCode;
@property (nonatomic, strong) NSMutableData *collectedData;
@end

@implementation BTPactolaRequest

- (void)dealloc
{
    self.connection = nil;
    self.collectedData = nil;
}

#pragma mark - Public

- (void)sendRequest
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self serverHost], [self requestEndpoint]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSData *payload = [self requestPayload];
    if(payload)
        [request setHTTPBody:payload];
    
    [request setHTTPMethod:[self requestMethod]];
    
    NSDictionary *headers = [self requestHeaders];
    for(NSString *key in headers.allKeys)
    {
        [request addValue:headers[key] forHTTPHeaderField:key];
    }

    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [self.connection start];
}

- (NSString *)serverHost;
{
    return @"http://pactola.io";
}

- (NSString *)requestEndpoint
{
    assert(0);
    return nil;
}

- (NSString *)requestMethod
{
    assert(0);
    return nil;
}

- (NSDictionary *)requestHeaders
{
    return nil;
}

- (NSData *)requestPayload
{
    return nil;
}

- (NSNumber *)maxResponseSize
{
    return @(1024*1024); // 1MB
}

- (void)response:(NSUInteger)statusCode withData:(NSData *)data
{
    if([self.delegate respondsToSelector:@selector(request:receivedResponse:withData:)])
        [self.delegate request:self receivedResponse:statusCode withData:data];
}

- (void)failedWithError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(request:failedWithError:)])
        [self.delegate request:self failedWithError:error];
}

#pragma mark - URLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self failedWithError:error];

    assert(self.connection == connection);
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    self.statusCode = httpResponse.statusCode;
    self.collectedData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Prevent overflow
    if((self.collectedData.length + data.length) > [[self maxResponseSize] integerValue])
    {
        // too much - close the connection and dump the data
        [connection cancel];
        self.collectedData = nil;
    }
    
    [self.collectedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    assert(self.connection == connection);
    self.connection = nil;
    
    [self response:self.statusCode withData:self.collectedData];
}

@end
