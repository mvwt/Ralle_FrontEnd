//
//  GearItem.swift
//  RALLE app
//
//  Created by Michael Thomas on 7/20/25.
//


import Foundation

struct GearItem: Identifiable, Codable {
    let id: Int
    let name: String
    let price: Int // Changed from Decimal to support Stripe, whose amounts are in cents
    let imageName: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageName = "image_name"
        
    }
}
