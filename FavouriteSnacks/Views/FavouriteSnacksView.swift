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
                
                HStack {
                    
                    Text(currentItem.item)
                        .textCase(.uppercase)
                    Text(currentItem.price)
                        .textCase(.uppercase)
                    Text(currentItem.type)
                        .textCase(.uppercase)
                }
//                .onTapGesture {
//                    Task{
//                        try await db!.transaction { core in
//                            //Change the status to the opposite
//                            try core.query("UPDATE Favourite set completed = (?) WHERE id = (?)", !currentItem.item, currentItem.id, currentItem.type, currentItem.price)
//                            
//                            
            }
            .onDelete(perform: removeRows)

        }
    }
    //MARK: Initalizer
    init(filteredOn searchText: String) {
        
        // Initialize
        _favouriteSnacks = BlackbirdLiveModels({ db in
            try await Favourite.read(from: db, sqlWhere: "description LIKE ?", "%\(searchText)%")
        })
        
 }
    //MARK: Functions
    func removeRows(at offsets: IndexSet) {
        
        Task {
            
            try await db!.transaction { core in
                
                // Get the id of the item to be deleted
                var idList = ""
                for offset in offsets {
                    idList += "\(favouriteSnacks.results[offset].id),"
                }
                
                // remove the final comma
                print(idList)
                idList.removeLast()
                print(idList)
                
                //Delete the row from the database
                try core.query("DELETE FROM Favourite WHERE id IN (?)", idList)
                print("Finished deleting")
                
            }
            
            
        }

        
    }
}

struct FavouriteSnacksView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteSnacksView(filteredOn: "")
        // make the database available to all other views through the enviornment
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
