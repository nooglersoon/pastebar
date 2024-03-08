import SwiftUI

public struct CoreView: View {
    
    public init(){}
    
    public var body: some View {
        RoundedRectangle(cornerRadius: 4, style: .continuous)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .foregroundStyle(Color.customGreen)
    }
}

public extension Color {
    static let customGreen = Color("MainGreen", bundle: .module)
}

#Preview {
    CoreView()
}
