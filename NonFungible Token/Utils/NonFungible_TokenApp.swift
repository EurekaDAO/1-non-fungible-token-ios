//
//  NonFungible_TokenApp.swift
//  NonFungible Token
//
//  Created by BoiseITGuru on 8/27/22.
//

import SwiftUI

@main
struct NonFungible_TokenApp: App {
    @StateObject var fclModel = FCLModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(fclModel)
        }
    }
}
