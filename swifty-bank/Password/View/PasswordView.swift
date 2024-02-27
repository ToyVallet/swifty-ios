import SwiftUI

struct PasswordView: View {
    
    @EnvironmentObject var passwordViewModel: PasswordViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    let frameWidth = UIScreen.main.bounds.width
    let frameHeight = UIScreen.main.bounds.height - DOCK_HEIGHT
    
    @FocusState var keyboardEnabled: Bool
    
    var body: some View {
        VStack(alignment: .center, content: {
            Spacer()
                .frame(height: 50)
            VStack(alignment: .leading, content: {
                Text("비밀번호를 설정해주세요")
                    .font(.headline1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 9)
                Text("3자리 이상 반복되거나 연속되지 않도록\n생년월일, 전화번호가 포함되지 않도록 입력해주세요.")
                    .font(.body1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            })
            .padding(EdgeInsets(top: 0, leading: 18, bottom: 0, trailing: 0))
            Spacer()
                .frame(height: 59)
            ZStack{
                HStack{
                    ForEach(0..<6){ num in
                        InputItem(char: passwordViewModel.getCurrentInput(index: num))
                    }
                    .frame(width: 28)
                    .onTapGesture {
                        keyboardEnabled = true
                    }
                }
                .padding([.leading, .trailing])
                .frame(width: frameWidth - 100, height: 55)
                
//                TextField("비밀번호를 설정해주세요", text:Binding(
//                    get: { passwordViewModel.getCurrentInput() },
//                    set: { passwordViewModel.setCurrentInput(value: $0) }
//                ))
//                .frame(maxWidth: .infinity, maxHeight: 55)
//                .opacity(0)
//                .allowsHitTesting(true)
//                .focused($keyboardEnabled)
            }
            Spacer()
                .frame(minHeight: 25)
            Spacer()
            HStack{
                NumberPadItem(number: 1)
                NumberPadItem(number: 2)
                NumberPadItem(number: 3)
            }
            HStack{
                NumberPadItem(number: 4)
                NumberPadItem(number: 5)
                NumberPadItem(number: 6)
            }
            HStack{
                NumberPadItem(number: 7)
                NumberPadItem(number: 8)
                NumberPadItem(number: 9)
            }
            HStack{
                NumberPadItem(backspace: true)
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                NumberPadItem(number: 0)
                NumberPadItem(backspace: true)
            }
        })
        .padding(EdgeInsets(top: 6, leading: 13, bottom: 6, trailing: 13))
    }
    
}



struct PasswordView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordView()
            .environmentObject(PasswordViewModel())
    }
}
