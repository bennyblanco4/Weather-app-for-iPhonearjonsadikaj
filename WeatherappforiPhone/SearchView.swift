import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    let onSearch: (String) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter city name", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    if !searchText.isEmpty {
                        onSearch(searchText)
                    }
                }) {
                    Text("Search")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                        )
                        .padding(.horizontal)
                }
                .disabled(searchText.isEmpty)
                .opacity(searchText.isEmpty ? 0.6 : 1)
                
                Spacer()
            }
            .padding(.top, 20)
            .navigationTitle("Search Location")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}