import SwiftUI

struct NumberPadItem: View {
    
    @EnvironmentObject var passwordViewModel: PasswordViewModel
    var number: Int?
    var backspace = false
    @State var touchStateOpacity = TouchState.none
    @State var touchStateScale = TouchState.none
    
    
    var body: some View {
        if number != nil || backspace {
            ZStack{
                //scaling circle
                Circle()
                    .scaledToFit()
                    .foregroundColor(.accentMaster)
                    .scaleEffect(touchStateOpacity == .began || touchStateOpacity == .moved ? 1 : 0.5)
                    .opacity(touchStateScale == .began || touchStateScale == .moved ? 0.2 : 0)
                
                //background circle
                Circle()
                    .scaledToFit()
                    .foregroundColor(.accentMaster)
                    .opacity(touchStateScale == .began || touchStateScale == .moved ? 0.1 : 0)
                
                //content
                HStack(alignment: .center, content: {
                    Text((number != nil) ? String(number!) : "←")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .font(.numericKeypad)
                        .foregroundColor(touchStateOpacity == .began || touchStateOpacity == .moved ? .accentMaster : .textSubdued)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                })
                .contentShape(Rectangle())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ (touch) in
                            withAnimation(.easeOut(duration: 0.3)){
                                touchStateScale = (self.touchStateScale == .none || self.touchStateScale == .ended) ? .began : .moved
                            }
                            withAnimation(.easeOut(duration: 0.3)){
                                touchStateOpacity = (self.touchStateOpacity == .none || self.touchStateOpacity == .ended) ? .began : .moved
                            }
                        })
                        .onEnded({ (touch) in
                            let tmp = UIImpactFeedbackGenerator(style: .light)
                            tmp.prepare()
                            
                            withAnimation(.easeIn(duration: 0.2)){
                                touchStateScale = .ended
                            }
                            withAnimation(.easeIn(duration: 1)){
                                touchStateOpacity = .ended
                            }
                            
                            if backspace || number != nil {
                                withAnimation(.easeOut(duration: 0.14)){
                                    if backspace {
                                        passwordViewModel.backspace()
                                    }
                                    else if number != nil {
                                        passwordViewModel.setCurrentInput(value: passwordViewModel.getCurrentInput() + String(number!))
                                    }
                                }
                            }
                            tmp.impactOccurred()
                        })
                )
            }
        } else {
            Spacer()
                .frame(maxWidth: .infinity)
        }
    }
    
}



struct NumberPadItem_Previews: PreviewProvider {
    static var previews: some View {
        NumberPadItem(number: 2)
            .environmentObject(PasswordViewModel())
    }
}

