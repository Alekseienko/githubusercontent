//
//  Helper.swift
//  githubusercontentTEST
//
//  Created by Volodymyr Alekseienko on 09.09.2023.
//

import UIKit

class Helper {
    static let shared = Helper()
        
    func showCustomAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        viewController.present(alert, animated: true)
    }
    
    
    
    
    func getTimeSince(timeshamp: Int, isShort: Bool = false) -> String {
        var formattedString = String()
        let now = Date()
         
        let date = Date(timeIntervalSince1970: TimeInterval(timeshamp))
        let secondsAgo = Int(now.timeIntervalSince(date))
        
        let twoSeconds = 2
        let minute = 60
        let twoMinutes = minute * 2
        let hour = 60 * minute
        let twoHours = hour * 2
        let day = 24 * hour
        let twoDays = day * 2
        let week = 7 * day
        let twoWeeks = week * 2
        let month = 4 * week
        let twoMonths = month * 2
        let year = 12 * month
        let twoYears = year * 2
        
        let secondString = isShort ? "s ago" : " second ago"
        let secondsString = isShort ? "s ago" : " seconds ago"
        let minuteString = isShort ? "m ago" : " minute ago"
        let minutesString = isShort ? "m ago" : " minutes ago"
        let hourString = isShort ? "h ago" : " hour ago"
        let hoursString = isShort ? "h ago" : " hours ago"
        let dayString = isShort ? "d ago" : " day ago"
        let daysString = isShort ? "d ago" : " days ago"
        let weekString = isShort ? "w ago" : " week ago"
        let weeksString = isShort ? "w ago" : " weeks ago"
        let monthString = isShort ? "mo ago" : " month ago"
        let monthsString = isShort ? "mo ago" : " months ago"
        let yearString = isShort ? "y ago" : " year ago"
        let yearsString = isShort ? "y ago" : " years ago"
        
        if secondsAgo < twoSeconds {
            formattedString = "\(secondsAgo)\(secondString)"
        } else if secondsAgo < minute {
            formattedString = "\(secondsAgo)\(secondsString)"
        } else if secondsAgo < twoMinutes {
            formattedString = "\(secondsAgo / minute)\(minuteString)"
        } else if secondsAgo < hour {
            formattedString = "\(secondsAgo / minute)\(minutesString)"
        } else if secondsAgo < twoHours {
            formattedString = "\(secondsAgo / hour)\(hourString)"
        } else if secondsAgo < day {
            formattedString = "\(secondsAgo / hour)\(hoursString)"
        } else if secondsAgo < twoDays {
            formattedString = "\(secondsAgo / day)\(dayString)"
        } else if secondsAgo < week {
            formattedString = "\(secondsAgo / day)\(daysString)"
        } else if secondsAgo < twoWeeks {
            formattedString = "\(secondsAgo / week)\(weekString)"
        } else if secondsAgo < month {
            formattedString = "\(secondsAgo / week)\(weeksString)"
        } else if secondsAgo < twoMonths {
            formattedString = "\(secondsAgo / month)\(monthString)"
        } else if secondsAgo < year {
            formattedString = "\(secondsAgo / month)\(monthsString)"
        } else if secondsAgo < twoYears {
            formattedString = "\(secondsAgo / year)\(yearString)"
        } else {
            formattedString = "\(secondsAgo / year)\(yearsString)"
        }
        return formattedString
    }
}
