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
                                try core.query("INSERT INTO FavouriteSnacks (item, price, type) VALUES (?,?,?)", newItem, newPrice, newType)
                            }
                            newItem = ""
                            newPrice = ""
                            newType = ""
                        }
                    }, label: {
                        Text("ADD")
                    })
                    
                    
                    
                    
                    
                }
                .padding(10)
            }
            .navigationTitle("Favourite Snacks")
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
