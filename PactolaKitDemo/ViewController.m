//
//  ViewController.m
//  PactolaKit
//
//  Created by Thaddeus Ternes on 9/23/14.
//  Copyright (c) 2014 Bluetoo. All rights reserved.
//

#import "ViewController.h"
#import "BTPactolaNotificationRequest.h"

@interface ViewController () <BTPactolaRequestDelegate>
@property (nonatomic, retain) BTPactolaNotificationRequest *request;

@property (nonatomic, assign) IBOutlet UITextField *deviceIdentifierField;
@property (nonatomic, assign) IBOutlet UITextField *titleField;
@property (nonatomic, assign) IBOutlet UITextField *messageField;
@property (nonatomic, assign) IBOutlet UISlider *badgeCountSlider;
@property (nonatomic, assign) IBOutlet UILabel *badgeCountLabel;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.deviceIdentifierField.text = @"qyFRUeAy";
    [self sliderChanged:self];
}

- (IBAction)buttonPressed:(id)sender
{
    self.request = [[[BTPactolaNotificationRequest alloc] init] autorelease];
    self.request.delegate = self;
    self.request.deviceIdentifier = self.deviceIdentifierField.text;
    self.request.title = self.titleField.text;
    self.request.message = self.messageField.text;
    self.request.badgeCount = [self badgeSliderCeiling];
    [self.request sendRequest];
}

- (IBAction)sliderChanged:(id)sender
{
    self.badgeCountLabel.text = [[self badgeSliderCeiling] stringValue];
}

- (NSNumber *)badgeSliderCeiling
{
    return @(ceilf(self.badgeCountSlider.value));
}

#pragma mark - Delegate

- (void)request:(BTPactolaRequest *)request receivedResponse:(NSUInteger)status withData:(NSData *)data
{
    NSLog(@"received %ld", (unsigned long)status);
    self.request = nil;
}

- (void)request:(BTPactolaRequest *)request failedWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
    self.request = nil;
}

@end
