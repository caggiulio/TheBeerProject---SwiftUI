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

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var beers: [Beer] = [Beer]()
    
    var body: some View {
        List(homeViewModel.beers, id: \.id) { beer in
            BeerListItem(beer: beer)
        }
        //this is called when the Publisher send an object
        /*.onReceive(homeViewModel.didChange) { (vm) in
            self.beers = vm.beers
        }*/
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeViewModel())
    }
}
