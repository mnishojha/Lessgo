import SwiftUI

struct ProfileView: View {
    @State private var navigateToSettings = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileImage(imageName: "Profile")
                ProfileName(name: "Manish Ojha")
                ProfileBio(bio: "Passionate traveler and food enthusiast. She loves exploring new cultures through their cuisines and beyond.")
                TagsView(tags: ["Anime", "Music", "Books", "Travel", "Movie", "English"])
                    .padding()
               
                Spacer()
            }
            .padding()
            .navigationBarItems(
                trailing: NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 22))
                }
            )
        }
    }
}

// Your existing components remain the same
struct ProfileImage: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 500, height: 500)
            .clipShape(Rectangle())
            .overlay(
                Rectangle()
                    .stroke(Color.white, lineWidth: 4)
            )
            .shadow(radius: 10)
    }
}

struct ProfileName: View {
    let name: String
    var body: some View {
        Text(name)
            .font(.title)
            .fontWeight(.bold)
            .padding(.top, 10)
    }
}

struct ProfileBio: View {
    let bio: String
    var body: some View {
        Text(bio)
            .font(.body)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
}

struct TagsView: View {
    let tags: [String]
    var body: some View {
        VStack {
            ForEach(tags.chunked(into: 3), id: \.self) { rowTags in
                HStack(spacing: 10) {
                    ForEach(rowTags, id: \.self) { tag in
                        Text(tag)
                            .padding(10)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .font(.caption)
                    }
                }
            }
        }
    }
}

// Helper extension remains the same
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [] }
        var result: [[Element]] = []
        var currentIndex = self.startIndex
        while currentIndex < self.endIndex {
            let nextIndex = self.index(currentIndex, offsetBy: size, limitedBy: self.endIndex) ?? self.endIndex
            let chunk = Array(self[currentIndex..<nextIndex])
            result.append(chunk)
            currentIndex = nextIndex
        }
        return result
    }
}

// Updated Settings View
struct SettingView: View {
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "English"
    
    let languages = ["English", "Spanish", "French", "German"]
    
    var body: some View {
        Form {
            Section(header: Text("Account")) {
                NavigationLink(destination: Text("Profile Details")) {
                    HStack {
                        Image(systemName: "person.circle")
                            .foregroundColor(.blue)
                        Text("Profile")
                    }
                }
                
                NavigationLink(destination: Text("Change Password")) {
                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundColor(.orange)
                        Text("Change Password")
                    }
                }
            }
            
            Section(header: Text("Preferences")) {
                Toggle(isOn: $notificationsEnabled) {
                    HStack {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.green)
                        Text("Notifications")
                    }
                }
                
                Picker(selection: $selectedLanguage, label: Text("Language")) {
                    ForEach(languages, id: \.self) { language in
                        Text(language)
                    }
                }
            }
            
            Section(header: Text("About")) {
                NavigationLink(destination: Text("Version 1.0.0")) {
                    HStack {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.blue)
                        Text("App Version")
                    }
                }
                
                NavigationLink(destination: Text("Lessgo is a travel app that connects you with like-minded travel companions. Happy travels!")) {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("About Lessgo")
                    }
                }
            }
            
            Section(header: Text("Support")) {
                NavigationLink(destination: Text("FAQs")) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(.gray)
                        Text("FAQs")
                    }
                }
                
                NavigationLink(destination: Text("Contact Us")) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.red)
                        Text("Contact Us")
                    }
                }
            }
            
            Section {
                Button(action: {
                    print("Logged out")
                }) {
                    HStack {
                        Image(systemName: "power")
                            .foregroundColor(.red)
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .preferredColorScheme(.dark)
        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
