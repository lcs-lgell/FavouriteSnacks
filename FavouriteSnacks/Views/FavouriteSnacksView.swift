//
//  FavouriteSnacksView.swift
//  FavouriteSnacks
//
//  Created by Leon Gell on 2023-04-19.
//

import Blackbird
import SwiftUI

struct FavouriteSnacksView: View {
    
    //MARK: Stored Properties
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels var favouriteSnacks: Blackbird.LiveResults<Favourite>
    
    
    //MARK: Computed Properties
    var body: some View {
        List {
            
            ForEach(favouriteSnacks.results) { currentItem in
                
                Label(title: {
                    Text(currentItem.item)
                        .textCase(.uppercase)
                    Text(currentItem.price)
                        .textCase(.uppercase)
                    Text(currentItem.type)
                        .textCase(.uppercase)
                }, icon: {
                   // NO ICON NEEDED
                })
            }
            
        }
    }
}

struct FavouriteSnacksView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteSnacksView()
        // make the database available to all other views through the enviornment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
