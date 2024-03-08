import SwiftUI
import UniformTypeIdentifiers
import ProductLanguageKit

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    
    @State private var textField: String = ""
    @State private var textLists: [String] = []
    @State private var selectedTab: Int = 0
    @State private var showSnackbar: Bool = false
    @State private var showSnackbarCopy: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Pastebar")
                .bold()
            HStack {
                TextField("Search...", text: $textField)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .textFieldStyle(PlainTextFieldStyle())
                    .background(.clear)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                Button {
                    textLists.append(textField)
                    textField = ""
                    showSnackbar.toggle()
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
                        ItemCellView(title: item, isCopyTapped: $showSnackbarCopy)
                        Divider()
                    }
                }
                .padding(.vertical)
            }
            .background(.clear)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .frame(width: 200, height: 300)
        .padding(16)
        .snackbar(message: "Success add new item", style: .success, show: $showSnackbar)
        .snackbar(message: "Success copy to clipboard", style: .success, show: $showSnackbarCopy)
    }
}

struct ItemCellView: View {
    
    let title: String
    @Binding var isCopyTapped: Bool
    
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
                        isCopyTapped.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 4)
                            .overlay {
                                Image(systemName: "doc.on.doc")
                                    .font(.subheadline)
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.clear)
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
