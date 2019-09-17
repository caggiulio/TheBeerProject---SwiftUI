//
//  ContentView.swift
//  The Beer Project - SwiftUI
//
//  Created by nunzio giulio caggegi on 13/09/2019.
//  Copyright © 2019 nunzio giulio caggegi. All rights reserved.
//

import SwiftUI
import URLImage
import PromiseKit
import Combine

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
        
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                SearchView(homeViewModel: _homeViewModel)
                BeerListView(homeViewModel: _homeViewModel)
            }
            .navigationBarTitle("The Beer Project", displayMode: .large)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewModel())
    }
}

struct SearchView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
        
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .padding(.leading, CGFloat(10.0))
            TextField("Search", text: $homeViewModel.searchText.string)
                .padding(.vertical, CGFloat(4.0))
                .padding(.trailing, CGFloat(10.0))
        }.padding()
    }
}

struct BeerListView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var beers: [Beer] = [Beer]()
    
    var body: some View {
        List(beers, id: \.id) { beer in
            BeerListItem(beer: beer)
                .onAppear() {
                    if beer.id == self.homeViewModel.beers.last?.id {
                        self.homeViewModel.getBeers(page: self.homeViewModel.page, beerName: self.homeViewModel.searchText.string, category: "")
                    }
                }
        }//this is called when the Publisher send an object
        .onReceive(homeViewModel.didChange) { (vm) in
            self.beers = vm.beers
        }
    }
}


