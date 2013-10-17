//
//  SMSCalendar.h
//  calendarPluginTest
//
//  Created by Hung Nguyen on 10/10/13.
//
//

#import <Cordova/CDV.h>
#import <EventKit/EventKit.h>

@interface SMSCalendar : CDVPlugin

- (void) cordovaAddNewEventToCalendar:(CDVInvokedUrlCommand*)command;

@end
