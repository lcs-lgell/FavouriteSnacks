//
//  FavouriteView.swift
//  FavouriteSnacks
//
//  Created by Leon Gell on 2023-04-19.
//

import Blackbird
import SwiftUI

struct FavouriteView: View {
    //MARK: Stored Properties
    
    @Environment(\.blackbirdDatabase) var db:
        Blackbird.Database?
    
    @State var newItem: String = ""
    
    @State var newPrice: String = ""
    
    @State var newType: String = ""
    
    // the list of favourite snacks
    @BlackbirdLiveModels({ db in
        try await Favourite.read(from: db)
    }) var bestSnacks
    
    //The current search text
    @State var searchText = ""
    
    //MARK: Computed Properties
    var body: some View {
        NavigationView {
            
            VStack {
                
                HStack {
                    
                    TextField("Snack", text: $newItem)
                        .frame(maxWidth: 60)
                    TextField("Price ?", text: $newPrice)
                        .frame(maxWidth: 60)
                    TextField("Sweet or Salty ?", text: $newType)
                    
                    Button(action: {
                        
                        Task {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Favourite (item, price, type) VALUES (?, ?, ?)", newItem, newPrice, newType)
                            }
                            newItem = ""
                            newPrice = ""
                            newType = ""
                        }
                    }, label: {
                        Text("ADD")
                    })
                    .padding(20)
                }
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
                
                FavouriteSnacksView(filteredOn: searchText)
                .searchable(text: $searchText)
            }
            .navigationTitle("Favourite Snacks")
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
        // make the database available to all other views through the enviornment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
