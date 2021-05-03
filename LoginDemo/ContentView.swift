

import SwiftUI


struct ContentView: View {
    
    @EnvironmentObject var model: Model
    
    @Binding var userName: String
    
    @State var waveHand: Bool = false
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "hand.wave.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100.0)
                .rotationEffect(Angle(degrees: waveHand ? -18.0 : 0.0))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.3).repeatForever()) {
                        waveHand.toggle()
                    }
                }
            
            Text("Hey \(userName)")
                .font(Font.title.weight(.semibold))
            
            Button(action: {
                self.model.accessGranted = false
            }, label: {
                Text("Logout")
                    .fontWeight(.bold)
            })
            .padding([.top], 24.0)
            
        }
        .preferredColorScheme(.dark)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userName: Binding.constant("Susan"))
    }
}
