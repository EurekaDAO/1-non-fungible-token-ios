//
//  FCLModel.swift
//  NonFungible Token
//
//  Created by BoiseITGuru on 8/27/22.
//

import BigInt
import Combine
import CryptoKit
import FCL
import Flow
import Foundation
import SafariServices
import SwiftUI
import LocalAuthentication

let testAccount = "0xf972a70aa4230c5b"

class FCLModel: NSObject, ObservableObject {
    @Published var defualtBackgroundColor = Color(hex: "011E30")
    @Published var defualtAccentColor = Color(hex: "38e8c6")
    @Published var defaultTextColor = Color(hex: "1e3a8a")

    @Published var env: Flow.ChainID = .testnet

    @Published var loggedIn = false

    @Published var address: String = ""

    @Published var provider: FCLProvider = .blocto

    @Published var isShowWeb: Bool = false

    @Published var isPresented: Bool = false

    @Published var currentObject: String = ""

    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()
        let metadata = FCL.Metadata(appName: "1-NonFungible-Token", appIcon: "https://i.imgur.com/ux3lYB9.png", location: "https://github.com/EurekaDAO/1-non-fungible-token-ios")

        fcl.config(metadata: metadata, env: env, provider: provider)

        self.changeConfig()
    }

    func changeWallet() {
        fcl.changeProvider(provider: provider, env: env)
    }
    
    func changeConfig() {
        switch self.env {
        case .testnet:
            fcl.config
                .put(.scope, value: "email")
                .put("0xDeployer", value: testAccount)
                .put("0xStandard", value: "0x631e88ae7f1d7c20")
        default:
            fcl.config
                .put(.scope, value: "email")
                .put("0xDeployer", value: "0xf8d6e0586b0a20c7")
        }
    }

    func authn() async {
        do {
            let result = try await fcl.authenticate()
            await MainActor.run {
                self.address = result.address ?? ""

                if self.address != "" {
                    self.loggedIn = true
                }
            }
        } catch {
            // TODO: Error handling
            print(error)
        }
    }

    func signOut() {
        self.address = ""
        self.loggedIn = false
        fcl.unauthenticate()
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context _: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_: SFSafariViewController, context _: UIViewControllerRepresentableContext<SafariView>) {}
}
