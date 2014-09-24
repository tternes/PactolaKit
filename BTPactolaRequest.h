//
//  BTPactolaRequest.h
//  Pactola
//
//  Created by Thaddeus Ternes on 8/21/14.
//  Copyright (c) 2014 Bluetoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BTPactolaRequestDelegate;
@interface BTPactolaRequest : NSObject

- (void)sendRequest;

/****************************************************************
    The following are useful for subclasses to implement in order
    to affect the behavior of the request object
 ****************************************************************/

/**
 *  Protocol and server/port information for creating the URL
 *  e.g. @"http://pactola.local:8080"
 *
 *  @return String with the protocol and host/port information
 */
- (NSString *)serverHost;


/**
 *  Relative URL for the request. Request subclasses implement this; base implementation asserts.
 *  e.g. @"/register"
 *
 *  @return URL for making the request
 */
- (NSString *)requestEndpoint;


/**
 *  HTTP Method - "GET", "PUT", etc.
 *
 *  @return HTTP method to be used with the request
 */
- (NSString *)requestMethod;


/**
 *  Additional header pairs to add to the request
 *
 *  @return Key/value pairs to add as fields to the request header
 */
- (NSDictionary *)requestHeaders;


/**
 *  Request payload to include with PUT and POST methods
 *
 *  @return Data containing document to be sent with the request
 */
- (NSData *)requestPayload;


/**
 *  The maximum size (in bytes) that will be read from the response before the connection is closed
 *  to prevent over-consumption of memory. nil response is interpreted as no-limit.
 *
 *  @return Number of bytes to be allocated, or nil if no limit should be imposed. (!!!)
 */
- (NSNumber *)maxResponseSize;

/**
 *  Sent by the base class when the request has completed and all data has been read.
 *  If a sublasses implements this message, it should call be sure to send to super.
 *
 *  @param statusCode HTTP status code returned from the request (200, 404, etc.)
 *  @param data       Data read from the response body, if available.
 */
- (void)response:(NSUInteger)statusCode withData:(NSData *)data;

- (void)failedWithError:(NSError *)error;

@property (nonatomic, weak) id<BTPactolaRequestDelegate> delegate;

@end

@protocol BTPactolaRequestDelegate <NSObject>

/**
 *  Sent when the request is read completely. Response and data is available to delegate for processing.
 *
 *  @param request Original request object
 *  @param status  HTTP status code from response (200, 404, etc.)
 *  @param data    Data read from the response body, if available
 */
- (void)request:(BTPactolaRequest *)request receivedResponse:(NSUInteger)status withData:(NSData *)data;

- (void)request:(BTPactolaRequest *)request failedWithError:(NSError *)error;

@end