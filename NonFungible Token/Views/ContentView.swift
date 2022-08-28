//
//  ContentView.swift
//  NonFungible Token
//
//  Created by BoiseITGuru on 8/27/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var fclModel: FCLModel
    
    var body: some View {
        if !fclModel.loggedIn {
            SignIn()
        } else {
            NonFungibleTokenView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
