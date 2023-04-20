//
//  BestView.swift
//  FavouriteSnacks
//
//  Created by Leon Gell on 2023-04-20.
//

import Blackbird
import SwiftUI

struct BestView: View {
    //MARK: Stored Properties
    
    // the list of favourite snacks
    @BlackbirdLiveModels({ db in
        try await Favourite.read(from: db)
    }) var bestSnacks
    
    //MARK: Computed Properties
    var body: some View {
        NavigationView {
        List(bestSnacks.results) { currentItem in
            VStack(alignment: .leading) {
                Text(currentItem.item)
                    .textCase(.uppercase)
                Text(currentItem.price)
                    .textCase(.uppercase)
                Text(currentItem.type)
                    .textCase(.uppercase)
                }
            }
        .navigationTitle("Best Snacks")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        BestView()
        // Make the databse accessible to all the different views.
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
