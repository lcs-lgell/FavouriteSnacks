//
//  FavouriteSnacksApp.swift
//  FavouriteSnacks
//
//  Created by Leon Gell on 2023-04-19.
//

import Blackbird
import SwiftUI

@main
struct FavouriteSnacksApp: App {
    var body: some Scene {
        WindowGroup {
            FavouriteView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
