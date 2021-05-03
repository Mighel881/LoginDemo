

import SwiftUI


struct LoginView: View {
    
    @EnvironmentObject var model: Model
    
    @State var userName: String = ""
    @State var password: String = ""
    @State private var failedAttempts: Int = 0
    @State private var displayErrorSheet: Bool = false
    
    var body: some View {
        return NavigationView {
            
            Form {
                
                Section(footer: FooterView(attempts: self.$failedAttempts)) {
                    
                    TextField("Username", text: self.$userName)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: self.$password, onCommit: {
                        self.validateLogin()
                    })
                    
                    Button(action: {
                        self.validateLogin()
                    }, label: {
                        Text("Login")
                            .accentColor(Color.blue)
                            .font(Font.body.bold())
                    })
                    
                    Button(action: {
                        
                        let newLoginAdded = model.addNewLogin(self.userName, pw: self.password)
                        if newLoginAdded {
                            self.model.accessGranted = true
                        } else {
                            self.displayErrorSheet.toggle()
                        }
                        
                    }, label: {
                        Text("Register")
                            .accentColor(Color.gray)
                            .font(Font.body.bold())
                    })
                    
                }
            }
            .navigationBarTitle("Login")
            .sheet(isPresented: $model.accessGranted, onDismiss: {
                self.model.accessGranted = false
                self.userName = ""
                self.password = ""
            }, content: {
                ContentView(userName: $userName)
            })
            .alert(isPresented: $displayErrorSheet, content: {
                Alert(title: Text("Error"), dismissButton: Alert.Button.cancel())
            })
            
        }
    }
    
    
    private func validateLogin() {
        let isValid = self.model.validateLogin(self.userName, pw: self.password)
        if !isValid {
            self.failedAttempts += 1
        } else {
            self.failedAttempts = 0
        }
    }
    
    
}


fileprivate struct FooterView: View {
    
    @Binding var attempts: Int
    
    var body: some View {
        if self.attempts == 0 {
            EmptyView()
        } else {
            Text("\(self.attempts) failed attempts")
                .font(Font.caption.weight(.semibold).monospacedDigit())
        }
    }
    
}

