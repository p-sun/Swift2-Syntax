// Date and Time

import EventKit

// NSDate -------------------------------------------

func addOneWeek(date: NSDate) -> NSDate {
    let oneWeekInSeconds = 60*60*24*7.0
    return NSDate(timeInterval: oneWeekInSeconds, sinceDate: date)
}
addOneWeek(NSDate())

// NSCalendar ------------------------------------

let currentCalendar = NSCalendar.currentCalendar()

if let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
    
    // NSDateCompoments -> NSDate
    let dateComponents = NSDateComponents()
    dateComponents.day = 21
    dateComponents.month = 7
    dateComponents.year = 2019
    let date: NSDate = gregorianCalendar.dateFromComponents(dateComponents)!
    
    // Get weekday from the date created above
    let weekday = gregorianCalendar.component(.Weekday, fromDate: date)
    print(weekday) // 5, which corresponds to Thursday in the Gregorian Calendar
    
    // NSDate -> Specific NSDateComponent  
    // i.e. Get .Weekday .Month .Day from a NSDate()
    let today = NSDate()
    let todayweekday = gregorianCalendar.component(.Weekday, fromDate: today)
    print(todayweekday)

    // Get tomorrow with hour, minute, secconds
    let tomorrow: NSDate? = gregorianCalendar.nextDateAfterDate(today, matchingHour: 1, minute: 2, second: 3, options: NSCalendarOptions.MatchNextTime)
    // Get next Monday
    let nextMonday: NSDate? = gregorianCalendar.nextDateAfterDate(today, matchingUnit: NSCalendarUnit.Weekday, value: 2, options: NSCalendarOptions.MatchNextTime)
    // Get next Monday in August at a specific month, hour, and minute
    let components = NSDateComponents()
    components.weekday = 2
    components.month = 8
    components.hour = 18
    components.minute = 4
    gregorianCalendar.nextDateAfterDate(today, matchingComponents: components, options: NSCalendarOptions.MatchStrictly)
        // Note! You must check that the date you are looking for is indeed after. Otherwise it'll crash.
    
    // Get the weekday strings of the calendar
    let weekdays: [String] = gregorianCalendar.standaloneWeekdaySymbols
    
    // Get which weekday is the first day of the week. 
    gregorianCalendar.firstWeekday // 1 = Sunday
    
}

// EKWeekday (EventKit Weekday) --------------------------------------

/** Given an index from 0...6 (Corresponding to Monday(0) to Sunday(6))
 Return an index from 1...7 (Corresponding to Sunday(1) to Saturday(7))
 */
func NSCalenderWeekdayIndexFomMyWeekdayIndex (index: Int) -> Int {
    return (index + 8) % 7 + 1
}
    // Week 1
NSCalenderWeekdayIndexFomMyWeekdayIndex(0) // Monday is 2
NSCalenderWeekdayIndexFomMyWeekdayIndex(4) // Friday is 6
NSCalenderWeekdayIndexFomMyWeekdayIndex(5) // Saturday is 7
NSCalenderWeekdayIndexFomMyWeekdayIndex(6) // Sunday is 1
    // Week 2
NSCalenderWeekdayIndexFomMyWeekdayIndex(7) // Monday is 2
NSCalenderWeekdayIndexFomMyWeekdayIndex(13) // Sunday is 1

EKWeekday.Sunday.rawValue
EKWeekday.Monday.rawValue
EKWeekday.Saturday.rawValue

/** Given an index 0...13, return which day of the week it is. i.e. 7 -> "Monday".
 */
func weekdayStringFromIndex (index: Int) -> String {
    let day: Int = index % 7
    let daysOfTheWeek = ["NRV_MONDAY", "NRV_TUESDAY", "NRV_WEDNESDAY", "NRV_THURSDAY", "NRV_FRIDAY", "NRV_SATAURDAY", "NRV_SUNDAY"]
    return daysOfTheWeek[day]
}
weekdayStringFromIndex(0)
weekdayStringFromIndex(13)

/** Returns the index from 0...13 calculated from week and day.
 Parameter week: 1...2.
 Parameter day: 0...6.
 */
func getScheduleIndex (weekNum: Int, dayNum: Int) -> Int {
    return (weekNum - 1) * 7 + dayNum
}
getScheduleIndex(2, dayNum: 0)

/** Given an index 0...13,
 return the EKRecurrenceDayOfWeek.
 i.e.
 0 -> EKRecurrenceDayOfWeek.init(.Monday, weekNumber: 0)
 8 -> EKRecurrenceDayOfWeek.init(.Tuesday, weekNumber: 1)
 */
func EKRecurrenceDaysOfWeekFromIndex (index: Int) -> EKRecurrenceDayOfWeek {
    let day: Int = index % 7
    let week: Int = index / 7
    let daysOfTheWeek = [EKWeekday.Monday, EKWeekday.Tuesday, EKWeekday.Wednesday, EKWeekday.Thursday, EKWeekday.Friday, EKWeekday.Saturday, EKWeekday.Sunday]
    return EKRecurrenceDayOfWeek.init(daysOfTheWeek[day], weekNumber: week)
}
EKWeekday.Tuesday.rawValue
EKRecurrenceDaysOfWeekFromIndex(8).dayOfTheWeek.rawValue
EKRecurrenceDaysOfWeekFromIndex(8).weekNumber
