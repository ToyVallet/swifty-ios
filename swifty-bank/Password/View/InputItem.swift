import SwiftUI

struct InputItem: View {
    
    @EnvironmentObject var passwordViewModel: PasswordViewModel
    var char: String
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Circle()
                .fill(String(char) == "" ? .backgroundSubdued : .accentMaster)
                .opacity(0.2)
                .frame(maxWidth: 20, maxHeight: 20)
            Circle()
                .fill(String(char) == "" ? .backgroundSubdued : .accentMaster)
                .scaleEffect(String(char) == "" ? 0 : 1)
                .opacity(String(char) == "" ? 0 : 1)
                .frame(maxWidth: 20, maxHeight: 20)
        })
    }
    
}



struct InputItem_Previews: PreviewProvider {
    static var previews: some View {
        InputItem(char: "0")
            .environmentObject(PasswordViewModel())
        InputItem(char: "0")
            .environmentObject(PasswordViewModel())
        InputItem(char: "0")
            .environmentObject(PasswordViewModel())
        InputItem(char: "0")
            .environmentObject(PasswordViewModel())
    }
}
