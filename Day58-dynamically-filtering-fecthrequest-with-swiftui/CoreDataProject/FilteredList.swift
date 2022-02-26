//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Yi An Chen on 2022/2/26.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @State private var score = 0 //and then, change score = 10, score is stored by State Struct
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _score = State(initialValue: 3) // underscore(_) means to attach state wrapper itself
        //%k
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)) //change the whole fecthRequest itself
        self.content = content //stash away this function for laster on
        //Swift by default assume use closure immediatly inside the initializer, so it can't have to write up memory management, it will immediate call and move on
    }
}
