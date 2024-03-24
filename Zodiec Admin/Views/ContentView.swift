//
//  ContentView.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 27/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab : Int = 0
    var body: some View {
        ZStack{
            TabView(selection : $selectedTab){
                HomeView()
                    .tabItem {
                        Label("Menu", systemImage: "house.circle")
                    }
                AddProductView()
                    .tabItem {
                        Label("Product", systemImage: "tray.circle")
                    }
                AddCategoryView()
                    .tabItem {
                        Label("Menu", systemImage: "book.closed.fill")
                    }
            }
        }//:ZStack
     }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 Pro Max")
    }
}
