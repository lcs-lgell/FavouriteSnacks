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
            TabView {
                
                FavouriteView()
                    .tabItem {
                        Label("What Snack", systemImage: "fork.knife")
                    }
//                BestView()
//                    .tabItem {
//                        Label("Best Snack", systemImage: "1.circle")
//                    }
            }
            
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
