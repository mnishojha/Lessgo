import SwiftUI

struct LanguageSelectionView: View {
    @State private var searchText = ""
    @State private var selectedLanguages: Set<String> = ["English"]
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
        NavigationView {
            VStack(alignment: .leading) {
                // Title text
                Text("How many languages do you speak")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                // Selected languages
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

                // List of languages
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

                // Continue button
                Button(action: {
                    // Action when the Continue button is pressed
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(selectedLanguages.isEmpty) // Disable if no languages selected
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .navigationBarBackButtonHidden(true)
        }
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
        LanguageSelectionView()
            .preferredColorScheme(.dark) // Set preview to dark mode
    }
}
