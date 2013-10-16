//
//  SMSCalendar.m
//  calendarPluginTest
//
//  Created by Hung Nguyen on 10/10/13.
//
//

#import "SMSCalendar.h"

@implementation SMSCalendar

- (void)cordovaAddNewEventToCalendar:(CDVInvokedUrlCommand*)command
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    if ([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // the selector is available, so we must be on iOS 6 or newer
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    
                }
                else if (!granted)
                {
                    [self showAlertWithText:@"Please go to Preferences -> Privacy to add event to your calendar"];
                }
                else
                {
                    EKEvent *addEvent=[EKEvent eventWithEventStore:eventStore];
                    
                    [addEvent setCalendar:[eventStore defaultCalendarForNewEvents]];
                    
                    NSDictionary* eventInfo = [command.arguments objectAtIndex:0];
                    
                    addEvent.title=[eventInfo objectForKey:@"title"];
                    addEvent.notes = [eventInfo objectForKey:@"description"];
                    
                    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                    [f setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    /*NSNumber* startDateInterval = [f numberFromString:[eventInfo objectForKey:@"startTimeMillis"]];
                    addEvent.startDate = [NSDate dateWithTimeIntervalSince1970:[startDateInterval longLongValue]];
                    NSNumber* endDateInterval = [eventInfo objectForKey:@"endTimeMillis"];
                    addEvent.endDate = [NSDate dateWithTimeIntervalSince1970:[endDateInterval longValue]];*/
                    NSString* startDateTimeStr = [eventInfo objectForKey:@"startDateTime"];
                    NSString* endDateTimeStr = [eventInfo objectForKey:@"endDateTime"];
                    
                    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
                    
                    addEvent.startDate = [dateFormatter dateFromString:startDateTimeStr];
                    addEvent.endDate = [dateFormatter dateFromString:endDateTimeStr];
                    
                    addEvent.location = [eventInfo objectForKey:@"eventLocation"];
                    
                    NSInteger minutesReminder = (NSInteger)[eventInfo valueForKey:@"reminderMins"];
                    
                    [addEvent addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * - minutesReminder]];
                    
                    [eventStore saveEvent:addEvent span:EKSpanThisEvent error:nil];
                    
                    //[self showAlertWithText:@"Event added"];
                }
            });
        }];
    }
}

- (void)showAlertWithText:(NSString*) text
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:text delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
