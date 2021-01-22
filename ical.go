package main

import (
	"strings"
	"time"
)

// FilterRecurringEvents filters out recurring events that end repeating before the specified date
func FilterRecurringEvents(data []EventInfo, from string) []EventInfo {
	fromDate, err := time.Parse("2006-01-02 00:00:00", from)
	if err != nil {
		panic(err)
	}

	tmp := data[:0]
	for _, event := range data {
		if eventEndsAfter(event.Recurring, fromDate) {
			tmp = append(tmp, event)
		}
	}
	return tmp
}

// eventEndsAfter checks if an event ends after the specified date
func eventEndsAfter(recurring string, from time.Time) bool {
	if recurring != "" {
		end := getEndRepeat(recurring)
		if end.After(time.Time{}) && !end.After(from) {
			return false
		}
		return true
	}
	return true
}

// getEndRepeat gets the date by which event stops repeating
func getEndRepeat(recpattern string) time.Time {
	// FREQ=DAILY;INTERVAL=2;UNTIL=20211023T000000Z;
	endRepeat := time.Time{}

	parts := strings.Split(recpattern, ";")
	for _, part := range parts {
		pair := strings.Split(part, "=")
		if pair[0] == "UNTIL" {
			endRepeat, err := time.Parse("20060102T000000Z", pair[1])
			if err != nil {
				panic(err)
			}
			return endRepeat
		}
	}

	return endRepeat
}
