//
//  BTPactolaNotificationRequest.h
//  PactolaKit
//
//  Created by Thaddeus Ternes on 9/23/14.
//  Copyright (c) 2014 Bluetoo. All rights reserved.
//

#import "BTPactolaRequest.h"

@interface BTPactolaNotificationRequest : BTPactolaRequest

@property (nonatomic, retain) NSString *deviceIdentifier;

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSString *url;

@property (nonatomic, retain) NSNumber *badgeCount;

@end
