import SwiftUI

struct TabBarItem: View {
    let title: String
    let iconString: String
    
    @StateObject var viewRouter: ViewRouter
    var assignedPage: Page?
    
    @State var touchStateOpacity = TouchState.none
    @State var touchStateScale = TouchState.none
    
    var body: some View {
        ZStack{
            //scaling circle
            Circle()
                .scaledToFit()
                .foregroundColor(.accentMaster)
                .scaleEffect(touchStateScale == .began || touchStateScale == .moved ? 1.5 : 0.5)
                .opacity(touchStateOpacity == .began || touchStateOpacity == .moved ? 0.2 : 0)
            
            //background circle
            Circle()
                .scaledToFit()
                .foregroundColor(.accentMaster)
                .scaleEffect(1.5)
                .opacity(touchStateOpacity == .began || touchStateOpacity == .moved ? 0.1 : 0)
            
            VStack(alignment: .center){
                HStack(alignment: .top, content: {
                    Spacer()
                        .frame(width: 9, height: 35)
                    Image(iconString)
                        .resizable()
                        .frame(width: 35, height: 35)
                    
                    VStack{
                        Spacer()
                            .frame(height: 1)
                        Circle()
                            .foregroundColor(.accentMaster)
                            .frame(width: 9, height: 9)
                            .scaleEffect(viewRouter.currentPage == assignedPage ? 1 : 0.6)
                            .opacity(viewRouter.currentPage == assignedPage ? 1 : 0)
                    }
                    .padding(EdgeInsets(top: 0, leading: -8, bottom: 0, trailing: 0))
                    
                })
                Spacer()
                    .frame(height: 1)
                Text(title)
                    .font(.tabbar)
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ (touch) in
                        withAnimation(.easeOut(duration: 0.34)){
                            touchStateScale = (self.touchStateScale == .none || self.touchStateScale == .ended) ? .began : .moved
                        }
                        withAnimation(.easeOut(duration: 0.13)){
                            touchStateOpacity = (self.touchStateOpacity == .none || self.touchStateOpacity == .ended) ? .began : .moved
                        }
                    })
                    .onEnded({ (touch) in
                        let tmp = UIImpactFeedbackGenerator(style: .light)
                        tmp.prepare()
                        
                        if(assignedPage != nil && viewRouter.currentPage != assignedPage){
                            withAnimation(){
                                viewRouter.apply(page: assignedPage!)
                            }
                        }
                        
                        withAnimation(.easeIn(duration: 0.8)){
                            touchStateScale = .ended
                        }
                        withAnimation(.easeIn(duration: 0.3)){
                            touchStateOpacity = .ended
                        }
                    })
            )
        }
        .foregroundColor(viewRouter.currentPage == assignedPage ? .textMaster : .textSubdued)
        .frame(width: 80, height: 70)
        .contentShape(Rectangle())
    }
    
}

struct TabBarItem_Previews: PreviewProvider {
    static var previews: some View {
        HStack{
            TabBarItem(title: "홈", iconString: "Home", viewRouter: ViewRouter(), assignedPage: .test_home)
        }
    }
}
