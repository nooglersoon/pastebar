import SwiftUI
import CoreKit
import UniformTypeIdentifiers

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    
    @State private var textField: String = ""
    @State private var textLists: [String] = []
    @State private var selectedTab: Int = 0
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Pastebar")
                .bold()
            CoreView()
            HStack {
                TextField("Search...", text: $textField)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(.white)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                Button {
                    textLists.append(textField)
                    textField = ""
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.green)
                }
                .buttonStyle(.plain)
                .disabled(textField.isEmpty)
                .keyboardShortcut(.defaultAction)
            }
            ScrollView(showsIndicators: false) {
                VStack{
                    ForEach(textLists, id: \.self) { item in
                        ItemCellView(title: item)
                        Divider()
                    }
                }
                .padding(.vertical)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .frame(width: 200, height: 300)
        .padding(16)
    }
}

struct ItemCellView: View {
    
    let title: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.clear)
            .overlay {
                HStack(alignment: .center) {
                    Text(title)
                        .bold()
                    Spacer()
                    Button(action: {
                        let pasteboard = NSPasteboard.general
                        pasteboard.declareTypes([.string], owner: nil)
                        pasteboard.setString(title, forType: .string)
                    }) {
                        RoundedRectangle(cornerRadius: 4)
                            .overlay {
                                Image(systemName: "doc.on.doc")
                                    .font(.subheadline)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical)
                .padding(.horizontal, 16)
            }
            .frame(height: 28)
    }
}

#Preview {
    ContentView()
}
