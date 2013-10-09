package com.smsmt.utils.calendar;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class SmsmtCalendarPlugin extends CordovaPlugin {
	public static final String ACTION_ADD_CALENDAR_ENTRY = "addCalendarEntry";

	@Override
	public boolean execute(String action, JSONArray args,
			CallbackContext callbackContext) throws JSONException {
		try {
			if (ACTION_ADD_CALENDAR_ENTRY.equals(action)) {
				JSONObject jsonArgs = args.getJSONObject(0);
				CalendarUtils calUtils = CalendarUtils.getInstance(this.cordova.getActivity());
				//calUtils.createLocalCalendar();
				calUtils.createEvent(jsonArgs);
				callbackContext.success();
				return true;
			}
			callbackContext.error("Invalid action");
			return false;
		} catch (Exception e) {
			System.err.println("Exception: " + e.getMessage());
			callbackContext.error(e.getMessage());
			return false;
		}

	}

}