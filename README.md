#PactolaKit

PactolaKit is a [Pactola API](http://pactola.io) client library written in Objective-C. It is used to send push notifications to a device with only a couple lines of code. Check out the code in `PactolaKit.xcodeproj` for a working example.

# Setup
Include the following files in your project:

* `BTPactolaRequest.h`
* `BTPactolaRequest.m`
* `BTPactolaNotificationRequest.h`
* `BTPactolaNotificationRequest.m`

# Usage

    BTPactolaNotificationRequest *request = [[BTPactolaNotificationRequest alloc] init];
    request.deviceIdentifier = @"123456";
    request.title = @"My App"
    request.message = @"Something Happened!"
    [request sendRequest];
