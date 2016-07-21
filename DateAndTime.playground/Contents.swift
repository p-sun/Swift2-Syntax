// Date and Time


import EventKit

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
