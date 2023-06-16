//
//  LoginUtils.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation

class LoginUtils {
    /// Validate if username is a valid email
    /// - Parameter username: Valid email
    /// - Returns: True if the username is valid
    class func isValidEmail(_ username:String) -> Bool{
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailPredicate.evaluate(with: username)
        return isValid
    }
    
    /// Validate if password is a valid
    /// - Parameter password: The password to validate
    /// - Returns: Return true if password have more of minPassword length
    class func isValidPassword(_ password:String) -> Bool{
        let isValid = password.count > Constants.passwordMinLength
        return isValid
    }
    
    /// Convert a NetworkError in string
    /// - Parameter error: The type of error to convert
    /// - Returns: String with error description
    class func getMessageError(_ error: NetworkError) -> String{
        switch error {
        case .badURL:
            return "Wrong url"
        case .decodingError:
            return "Deconding retuned data"
        case .noData:
            return "No data returned"
        case .serverError(let errorMsg):
            return errorMsg
        }
    }
}
