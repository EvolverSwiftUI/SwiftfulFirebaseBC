//
//  SettingsView.swift
//  SwiftfulFirebaseBC
//
//  Created by Sivaramaiah NAKKA on 19/03/23.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SettingsView(showSignInView: .constant(false))
        }
    }
}
