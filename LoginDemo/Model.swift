

import Foundation


final class Model: ObservableObject {
    
    /*
     This project was created to demonstrate the mechanisms of ObservableObject, @StateObject, @Published and @EnvironmentObject.
     Working with sensitive data this way in a real-world project isn’t safe nor good.
     */
    
    struct LoginData: Equatable {
        
        var user: String
        var password: String
        
        var isEmpty: Bool {
            return user == "" && password == ""
        }
        
    }
    
    
    private var validLogins: [LoginData] = [LoginData(user: "Susan", password: "kare"),
                                            LoginData(user: "Tim", password: "apple")]
    
    
    @Published var accessGranted: Bool = false
    
    
    func validateLogin(_ name: String, pw: String) -> Bool {
        let loginData = LoginData(user: name, password: pw)
        let isValid = self.validLogins.contains(loginData)
        
        self.accessGranted = isValid
        return isValid
    }
    
    
    func addNewLogin(_ name: String, pw: String) -> Bool {
        let loginData = LoginData(user: name, password: pw)
        
        guard !loginData.isEmpty else { return false }
        
        let knownLoginName = self.validLogins.contains(where: { $0.user == loginData.user })
        if knownLoginName {
            return false
        } else {
            validLogins.append(loginData)
            return true
        }
    }
    
    
    
}
