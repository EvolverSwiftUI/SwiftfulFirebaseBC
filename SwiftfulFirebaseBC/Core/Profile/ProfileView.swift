//
//  ProfileView.swift
//  SwiftfulFirebaseBC
//
//  Created by Sivaramaiah NAKKA on 03/04/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
    
    func getUser(userId: String) async throws -> String {
        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        guard let data = snapshot.data() else {
            throw URLError(.badServerResponse)
        }
        return ""
    }
}

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView:Bool
    
    var body: some View {
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.uid)")
            }
        }
        .onAppear {
            try? viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView(showSignInView: .constant(false))
        }
    }
}
