import Foundation

class Validator {

    // Email validation
    func isValidEmail(_ email: String) -> Bool {
        // Define a regular expression for valid email addresses
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    // Password validation (at least 8 characters, 1 uppercase, 1 lowercase, 1 digit, 1 special character)
    func isValidPassword(_ password: String) -> Bool {
        // Define a regular expression for valid passwords
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+])[A-Za-z\\d!@#$%^&*()_+]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
    
    // Username validator 
    func isValidUsername(_ username: String) -> Bool {
        // Username should be 4-20 characters long and only contain alphanumeric characters
        let usernameRegex = "^[A-Za-z0-9]{4,20}$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernamePredicate.evaluate(with: username)
    }
}



