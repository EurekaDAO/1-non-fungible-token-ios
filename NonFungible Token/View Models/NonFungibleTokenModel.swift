//
//  NonFungibleTokenModel.swift
//  NonFungible Token
//
//  Created by BoiseITGuru on 8/27/22.
//

import Foundation
import FCL
import Flow

class NonFungibleTokenModel: ObservableObject {
    @Published var alertMsg: String = ""
    
    @Published var showAlert: Bool = false
    
    @Published var nfts: [NFT] = []
    
    @Published var transferAddress = ""
    
    func getNFTs() async {
        do {
            let block = try await fcl.query {
                cadence {
                    Scripts.getNFTs.rawValue
                }
                
                arguments {
                    [.address(fcl.currentUser!.addr)]
                }

                gasLimit {
                    1000
                }
            }.decode([NFT].self)
            await MainActor.run {
                nfts = block ?? []
            }
        } catch {
            // TODO: Error Handling
            print(error)
            await MainActor.run {
                alertMsg = "\(error)"
                showAlert.toggle()
            }
        }
    }
    
    func setupAccount() async {
        do {
            let txId = try await fcl.mutate {
                cadence {
                    Transactions.setupCollection.rawValue
                }

                gasLimit {
                    1000
                }
            }
            await MainActor.run {
                print("Transaction ID: \(txId)")
            }
        } catch {
            print(error)
        }
    }
}
