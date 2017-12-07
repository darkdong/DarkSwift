//
//  Date.swift
//  DarkSwift
//
//  Created by Calios on 12/7/17.
//  Copyright © 2017 Dark Dong. All rights reserved.
//

import Foundation

public extension Date {
	var isInToday: Bool {
		return Calendar.current.isDateInToday(self)
	}
	
	var isInThisWeek: Bool {
		return isInSameWeek(date: Date())
	}
	
	var isInTheFuture: Bool {
		return Date() < self
	}
	
	var isInThePast: Bool {
		return self < Date()
	}
	
	func isInSameDay(date: Date) -> Bool {
		return Calendar.current.isDate(self, equalTo: date, toGranularity: .day)
	}
	
	func isInSameWeek(date: Date) -> Bool {
		return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
	}
	
	func isInSameMonth(date: Date) -> Bool {
		return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
	}
	
	func isInSameYear(date: Date) -> Bool {
		return Calendar.current.isDate(self, equalTo: date, toGranularity: .year)
	}
}
