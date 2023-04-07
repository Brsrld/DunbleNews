//
//  String+Extension.swift
//  DunbleNews
//
//  Created by Barış ŞARALDI on 1.04.2023.
//

import Foundation

extension String {
    func calculateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else { return ""}
        let calculatedTime = abs(date.hours(from: .now))
        if calculatedTime > 24 {
            return "\(abs(date.days(from: .now))) days"
        } else {
            return "\(abs(date.days(from: .now))) hours"
        }
    }
    
    func isValid() -> Bool {
        if self.first == " " {
            return true
        } else {
            return false
        }
    }
}

