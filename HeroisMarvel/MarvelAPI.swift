//
//  MarvelAPI.swift
//  HeroisMarvel
//
//  Created by Thiago Antonio Ramalho on 11/01/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation
import SwiftHash
import Alamofire
import Keys

class MarvelAPI {
    private var keys:HeroisMarvelKeys
    private let basePath = "https://gateway.marvel.com:443/v1/public/characters"
    private let limit = 20
    
    init() {
       keys = HeroisMarvelKeys()
    }
    
    func loadHeroes(name: String?, page: Int = 0, onComplete: @escaping (MarvelInfo?) -> Void) {
        
        let offset = page * limit
        
        var startsWith = ""
        
        if let name = name, !name.isEmpty {
            startsWith = "nameStartsWith=\(name)&"
        }
        
        let url = "\(basePath)?offset=\(offset)&limit=\(limit)&\(startsWith)\(getCredentials())"
        print(url)
        
        Alamofire.request(url).responseJSON { (response) in

            guard let data = response.data else {
                onComplete(nil)
                return
            }
        
            do {
                let marvelInfo = try JSONDecoder().decode(MarvelInfo.self, from: data)
                onComplete(marvelInfo)
            } catch {
                print(error.localizedDescription)
                onComplete(nil)
            }
            
        }
    }
    
    private func getCredentials() -> String {
        
        let publicKey = keys.heroisMarvelPublicApiKey
        let privateKey = keys.heroisMarvelPrivateApiKey
        
        let ts = String(Date().timeIntervalSince1970)
        
        let hash = MD5("\(ts)\(privateKey)\(publicKey)").lowercased()
        
        return "ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
}
