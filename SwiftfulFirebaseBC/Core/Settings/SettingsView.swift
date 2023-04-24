//
//  SettingsView.swift
//  SwiftfulFirebaseBC
//
//  Created by Sivaramaiah NAKKA on 19/03/23.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        List {
            
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        print("LOG OUT!")
                        showSignInView = true
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }
            
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        print("ACCOUNT DELETED!")
                        showSignInView = true
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            } label: {
                Text("Delete account")
            }

            if viewModel.authProviders.contains(.email) {
                emailSection
            }
            
            if viewModel.authUser?.isAnonymous == true {
                anonymousSection
            }
        }
        .onAppear {
            viewModel.loadAuthProviders()
            viewModel.loadAuthUser()
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


extension SettingsView {
    private var emailSection: some View {
        Section {
            Button("Reset password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("PASSWORD RESET!")
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }

            Button("Update password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("PASSWORD UPDATED!")
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }

            Button("Update email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("EMAIL UPDATED!")
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }
        } header: {
            Text("Email functions")
        }
    }
    
    var anonymousSection: some View {
        Section {
            Button("Link Google Account") {
                Task {
                    do {
                        try await viewModel.linkGoogleAccount()
                        print("GOOGLE LINKED!".uppercased())
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }
            
            Button("Link Email Account") {
                Task {
                    do {
                        try await viewModel.linkEmailAccount()
                        print("EMAIL LINKED!".uppercased())
                    } catch {
                        print("Error: ", error.localizedDescription)
                    }
                }
            }
            
        } header: {
            Text("Create account")
        }
    }
}
