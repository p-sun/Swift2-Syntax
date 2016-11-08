// Date and Time

import EventKit

// NSDate -------------------------------------------

func addNWeeks(fromToday: NSDate, n: Int) -> NSDate {
    let aWeekFromToday = NSCalendar.currentCalendar()
        .dateByAddingUnit(.Day, value: 7*n, toDate: fromToday, options: []
    )
    return aWeekFromToday!
}
addNWeeks(NSDate(), n: 2)


func addOneDay(today: NSDate) -> NSDate {
    // If you simply add 24*60*60 seconds, you will not account for daylight savings time.
    let tomorrow = NSCalendar.currentCalendar()
        .dateByAddingUnit(.Day, value: 1, toDate: today, options: []
    )
    return tomorrow!
}

func removeOneDay(today: NSDate) -> NSDate {
    let yesterday = NSCalendar.currentCalendar()
        .dateByAddingUnit(.Day, value: -1, toDate: today, options: []
    )
    return yesterday!
}
removeOneDay(NSDate())

func addOneYear(today: NSDate) -> NSDate {
    let nextYear = NSCalendar.currentCalendar().dateByAddingUnit(.Year, value: 1, toDate: today, options: [])
    return nextYear!
}
addOneYear(NSDate())

NSDate.timeIntervalSinceReferenceDate() // Seconds since Jan, 1, 2001

func midnightOfDate(date: NSDate) -> NSDate? {
    let gregorianCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let midnight = gregorianCalendar.nextDateAfterDate(date, matchingHour: 23, minute: 59, second: 59, options: NSCalendarOptions.MatchNextTime)
    return midnight
}
midnightOfDate(NSDate())

func addNYears(today: NSDate, n: Int) -> NSDate {
    let nyearsInFuture = NSCalendar.currentCalendar()
        .dateByAddingUnit(
            .Month,
            value: 12 * n,
            toDate: today,
            options: []
    )
    return nyearsInFuture!
}

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

// Using 0...6 to refer to weekday numbers instead of 1...7 ------------

/** Given an index from 0...6 (Corresponding to Monday(0) to Sunday(6))
 Return an index from 1...7 (Corresponding to Sunday(1) to Saturday(7))
 */
func NSCalenderWeekdayIndexFromMyWeekdayIndex (index: Int) -> Int {
    return (index + 7 + 1) % 7 + 1
}
    // Week 1
NSCalenderWeekdayIndexFromMyWeekdayIndex(0) // Monday is 2
NSCalenderWeekdayIndexFromMyWeekdayIndex(4) // Friday is 6
NSCalenderWeekdayIndexFromMyWeekdayIndex(5) // Saturday is 7
NSCalenderWeekdayIndexFromMyWeekdayIndex(6) // Sunday is 1
    // Week 2
NSCalenderWeekdayIndexFromMyWeekdayIndex(7) // Monday is 2
NSCalenderWeekdayIndexFromMyWeekdayIndex(13) // Sunday is 1

func MyWeekdayIndexFromNSCalenderWeekdayIndex (index: Int) -> Int {
    let weekdays = [5, 6, 0, 1, 2, 3, 4]
    return weekdays[index % 7]
}
MyWeekdayIndexFromNSCalenderWeekdayIndex(2) // Monday
MyWeekdayIndexFromNSCalenderWeekdayIndex(3) // Tues
MyWeekdayIndexFromNSCalenderWeekdayIndex(4) // Wed
MyWeekdayIndexFromNSCalenderWeekdayIndex(5) // Thurs
MyWeekdayIndexFromNSCalenderWeekdayIndex(6) // Fri
MyWeekdayIndexFromNSCalenderWeekdayIndex(7) // Sat
MyWeekdayIndexFromNSCalenderWeekdayIndex(1) // Sunday


// EKWeekday (EventKit Weekday) --------------------------------------

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

/** Given:
        * an index 0...13 (from which we know the weekNum & weekday (i.e. Monday)
        * a startDate
    Return:
        * The next date to occur on that weekday and weekNum
            * This next date can be on or after startDate
            * By default, we repeat a schedule every 2 weeks.
 */
func NSDateOfNextWeekday(index: Int, startDate: NSDate, weeksInSchedule: Int = 2) -> NSDate {
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    
    let NSWeekdayOfIndex = NSCalenderWeekdayIndexFromMyWeekdayIndex(index)
    let nextWeekday = calendar.nextDateAfterDate(removeOneDay(startDate), matchingUnit: NSCalendarUnit.Weekday, value: NSWeekdayOfIndex, options: NSCalendarOptions.MatchNextTime)
    
    let eventWeekday = index % 7
    let startNSWeekday = calendar.component(.Weekday, fromDate: startDate)
    let startWeekday = MyWeekdayIndexFromNSCalenderWeekdayIndex(startNSWeekday)
    var weeksFromStartWeek = index / 7
    if weeksFromStartWeek == 0 && eventWeekday < startWeekday {
        weeksFromStartWeek = weeksInSchedule - 1
    } else if weeksFromStartWeek > 0 && eventWeekday < startWeekday {
        weeksFromStartWeek -= 1
    }
    let result = addNWeeks(nextWeekday!, n: weeksFromStartWeek)
    return result
}
let mondayFirstWeek = NSDateOfNextWeekday(3, startDate: NSDate())
let fridayFirstWeek = NSDateOfNextWeekday(4, startDate: NSDate())
let mondaySecondWeek = NSDateOfNextWeekday(7, startDate: NSDate())
let fridaySecondWeek = NSDateOfNextWeekday(11, startDate: NSDate())

let scheduleStartDate = NSDate(timeIntervalSinceReferenceDate: 499702509.0) // Nov 1
let startDay = NSDateOfNextWeekday(8, startDate: scheduleStartDate) // Should be Nov 8th. Tuesday of 2nd week, after daylight savings

// ----------

/** Return an NSDate combining the Date from an NSDate, and time from a String.
 */
func createNSDate(date: NSDate, time: String) -> NSDate {
    
    /** Takes an NSDate, and returns String in the format of
     yyyy-MM-dd HH:mm:ss ZZZ (PFObject format) in the device's timezone.
     */
    func formatNSDateToString2(date: NSDate?) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        //    dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        let dateString = dateFormatter.stringFromDate(date!)
        return dateString
    }
    
    let dateString = formatNSDateToString2(date)
    return createNSDateHelper(dateString, time: time)
}

func createNSDateHelper(date: String, time: String) -> NSDate {
    let index: String.Index = date.startIndex.advancedBy(10)
    let anewdate = date.substringToIndex(index)
    let newDateString = anewdate.stringByAppendingString(" \(time)")
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    dateFormatter.timeZone = NSTimeZone.systemTimeZone() // GMT -4
    let fdate = dateFormatter.dateFromString(newDateString)
    return fdate!
}


//let startDay = NSDate(timeIntervalSinceReferenceDate: 500097600.0) // Nov 6 12am
//let startDayWithTime = createNSDate(startDay, time: "17:00") // Nov 6 5pm
let endDay = addOneDay(startDay)
let endDayWithTime = createNSDate(endDay, time: "11:00") //Nov 7 11am

