//
//  AuthenticationViewModel.swift
//  SwiftfulFirebaseBC
//
//  Created by Sivaramaiah NAKKA on 03/04/23.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    func signInGoogle() async throws {
        let helper = SignInGoogleHelper()
        let tokens = try await helper.signIn()
        try await AuthenticationManager.shared.signInWithGoogle(tokens: tokens)
    }
    
    func signInAnonymous() async throws {
        try await AuthenticationManager.shared.signInAnonymous()
    }
}

