import SwiftUI

struct LanguageSelectionView: View {
    @ObservedObject var viewModel: ContentViewModel
    @State private var searchText = ""
    @State private var selectedLanguages: Set<String> = ["English"] // Default selection
    
    var onNext: () -> Void
    
    private let languages = [
        "English", "Mandarin Chinese", "Hindi", "Spanish", "French", "Standard Arabic",
        "Bengali", "Portuguese", "Russian", "Japanese", "Yue Chinese (Cantonese)", "German",
        "Korean", "Telugu", "Wu Chinese (Shanghainese)", "Marathi", "Tamil", "Turkish",
        "Urdu", "Min Nan Chinese", "Javanese", "Italian", "Hausa", "Thai", "Gujarati",
        "Persian (Farsi)", "Polish", "Pashto", "Kannada", "Xiang Chinese", "Malayalam",
        "Sundanese", "Hakka Chinese", "Odia", "Burmese", "Ukrainian", "Bhojpuri",
        "Tagalog (Filipino)", "Yoruba", "Maithili", "Swahili", "Hmong", "Serbo-Croatian",
        "Uzbek", "Sindhi", "Amharic", "Fula", "Romanian", "Oromo", "Igbo", "Azerbaijani",
        "Awadhi", "Gan Chinese", "Cebuano", "Dutch", "Kurdish", "Malagasy", "Saraiki",
        "Nepali", "Sinhalese", "Chittagonian", "Zhuang", "Khmer", "Turkmen", "Assamese",
        "Madurese", "Somali", "Marwari", "Magahi", "Haryanvi", "Hungarian", "Chhattisgarhi",
        "Greek", "Chewa", "Deccan", "Akan", "Kazakh", "Zulu", "Tunisian Arabic",
        "Sanaani Spoken Arabic", "Min Bei Chinese", "Rwanda-Rundi", "Czech", "Ta'izzi-Adeni Arabic",
        "Kinyarwanda", "Uyghur", "Eastern Punjabi", "Sylheti", "Haitian Creole",
        "Ilocano", "Quechua", "Kirundi", "Swedish", "Hmong Daw", "Shona", "Danish",
        "Mossi", "Yiddish", "Belarusian", "Balinese", "Wolof", "Kongo", "Tatar", "Haitian",
        "Afrikaans", "Tswana"
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            // Title
            Text("How many languages do you speak?")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 10)
            
            // Selected languages display
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Array(selectedLanguages), id: \.self) { language in
                        Text(language)
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical, 10)
            }
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: $searchText)
                    .foregroundColor(.white)
                    .padding(10)
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.bottom, 10)
            
            // Filtered languages list
            List {
                ForEach(filteredLanguages(), id: \.self) { language in
                    HStack {
                        Text(language)
                            .foregroundColor(.white)
                        Spacer()
                        if selectedLanguages.contains(language) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        } else {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 20, height: 20)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        toggleSelection(for: language)
                    }
                }
                .listRowBackground(Color.black)
            }
            .listStyle(PlainListStyle())
            .background(Color.black)
            
            Spacer()
            
            // ✅ New Continue Button
            Button(action: {
                onNext() // ✅ Go to the next step without modifying viewModel here
            }) {
                HStack {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title3)
                    
                    Text("Next Step")
                        .font(.headline)
                        .bold()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(selectedLanguages.count > 0 ? Color.blue : Color.gray.opacity(0.5))
                .clipShape(Capsule())
                .shadow(radius: 5)
                .padding(.horizontal, 24)
                .animation(.easeInOut, value: selectedLanguages.count)
            }
            .disabled(selectedLanguages.isEmpty) // ✅ Disable when no language is selected
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    private func toggleSelection(for language: String) {
        if selectedLanguages.contains(language) {
            selectedLanguages.remove(language)
        } else {
            selectedLanguages.insert(language)
        }
    }
    
    private func filteredLanguages() -> [String] {
        if searchText.isEmpty {
            return languages
        } else {
            return languages.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct LanguageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageSelectionView(viewModel: ContentViewModel()) {
            // Sample onNext action
        }
        .preferredColorScheme(.dark)
    }
}
