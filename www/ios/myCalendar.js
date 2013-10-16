var calendarPlugin = {
    createEvent: function(title, location, notes, startDateTime, endDateTime, reminderMins, successCallback, errorCallback) {
        cordova.exec(
			successCallback, // success callback function
			errorCallback, // error callback function
			'Calendar', // mapped to our native Java class called "CalendarPlugin"
			'cordovaAddNewEventToCalendar', // with this action name
			[{                  // and this array of custom arguments to create our entry
				"title": title,
				"description": notes,
				"eventLocation": location,
				"startDateTime": startDateTime,
				"endDateTime": endDateTime,
				"reminderMins": reminderMins
			}]
		);
    }
}
module.exports = calendarPlugin;