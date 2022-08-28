//
//  nftModel.swift
//  NonFungible Token
//
//  Created by BoiseITGuru on 8/27/22.
//

struct NFT: Identifiable, Codable {
    let id: UInt64
    let name: String
    let description: String
    let thumbnail: [String: String]
}
