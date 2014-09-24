//
//  BTPactolaNotificationRequest.h
//  PactolaKit
//
//  Created by Thaddeus Ternes on 9/23/14.
//  Copyright (c) 2014 Bluetoo. All rights reserved.
//

#import "BTPactolaRequest.h"

@interface BTPactolaNotificationRequest : BTPactolaRequest

@property (nonatomic, strong) NSString *deviceIdentifier;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSNumber *badgeCount;

@end
