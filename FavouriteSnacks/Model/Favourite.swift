//
//  Favourite.swift
//  FavouriteSnacks
//
//  Created by Leon Gell on 2023-04-19.
//

import Blackbird
import SwiftUI

struct Favourite: Identifiable, Codable, BlackbirdModel {
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var item: String
    @BlackbirdColumn var price: String
    @BlackbirdColumn var type: String
    
}
