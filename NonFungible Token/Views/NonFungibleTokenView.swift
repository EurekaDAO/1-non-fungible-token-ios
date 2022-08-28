//
//  NonFungibleTokenView.swift
//  NonFungible Token
//
//  Created by BoiseITGuru on 8/27/22.
//

import SwiftUI

struct NonFungibleTokenView: View {
    @EnvironmentObject var fclModel: FCLModel
    @ObservedObject var nonFungibleToken = NonFungibleTokenModel()
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                Text("Emerald")
                    .font(.title)
                Image("EC_Education")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                Text("Academy")
                    .font(.title)
            }
            Button(action: { Task { await nonFungibleToken.getNFTs() } }) {
                Text("Get NFTs")
                    .font(.title2)
                    .foregroundColor(fclModel.defaultTextColor)
            }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(fclModel.defualtAccentColor)
                .cornerRadius(15)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 20)
            
            List(nonFungibleToken.nfts, id: \.id) { nft in
                HStack {
                    Text(nft.name)
                    Spacer()
                    Text("\(nft.id)")
                }
                Text(nft.description)
                AsyncImage(url: URL(string: "https://cloudflare-ipfs.com/ipfs/\(nft.thumbnail["url"] ?? "")"))
                TextField("Transfer To Address", text: $nonFungibleToken.transferAddress)
                Button(action: { Task { await nonFungibleToken.getNFTs() } }) {
                    Text("Transfer")
                        .font(.title2)
                        .foregroundColor(fclModel.defaultTextColor)
                }
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(fclModel.defualtAccentColor)
                    .cornerRadius(15)
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 20)
            }

            
            Spacer()
            Button(action: { Task { await nonFungibleToken.setupAccount() } }) {
                Text("Setup Account")
                    .font(.title2)
                    .foregroundColor(fclModel.defaultTextColor)
            }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(fclModel.defualtAccentColor)
                .cornerRadius(15)
                .buttonStyle(PlainButtonStyle())
                .padding(.bottom, 2)
            Button(action: { fclModel.signOut() }) {
                Text("Sign Out")
                    .font(.title2)
                    .foregroundColor(fclModel.defaultTextColor)
            }
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(fclModel.defualtAccentColor)
                .cornerRadius(15)
                .buttonStyle(PlainButtonStyle())
        }
        .padding(20)
        .background(fclModel.defualtBackgroundColor)
        .alert(nonFungibleToken.alertMsg, isPresented: $nonFungibleToken.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct NonFungibleTokenView_Previews: PreviewProvider {
    static var previews: some View {
        NonFungibleTokenView()
    }
}
