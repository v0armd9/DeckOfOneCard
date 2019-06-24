//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Darin Marcus Armstrong on 6/24/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")
    
    static func drawCard(completion: @escaping (Card?) -> Void) {
        //Step 1 - Unwrap our optional base URL
        guard let url = baseURL else { completion(nil); return}
        
        //Step 2 - Construct your final URL
        //url.appendPathComponent(pathComponent: String)
        
        //Step 3 - Create a URLRequest to retrieve data
        //let request = URLRequest(url: url)
        
        //Step 4 - Get the data from the URLRequest
        do {
            let data = try Data(contentsOf: url)
            
            let Jdecoder = JSONDecoder()
            
            let topLevelJSON = try Jdecoder.decode(TopLevelJSON.self, from: data)
            
            let card = topLevelJSON.cards[0]
            
            completion(card)
            
        } catch {
            print("Error getting data from URL")
            completion(nil)
            return
        }
        
    }
    
    static func getImageFor(card: Card, completion: (UIImage?) ->()) {
        guard let imageUrl = URL(string: card.image) else { completion(nil); return}
        
        do {
            let data = try Data(contentsOf: imageUrl)
            
            let image = UIImage(data: data)
            
            completion(image)
            
        } catch {
            print("Error fetcching image for card: \(card.code)")
            completion(nil)
            return
        }
        
    }
}
