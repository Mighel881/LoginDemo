

import SwiftUI


@main
struct LoginDemoApp: App {
    
    @StateObject var model: Model = Model()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(self.model)
                .preferredColorScheme(.dark)
        }
    }
    
}
