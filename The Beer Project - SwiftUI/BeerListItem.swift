//
//  BeerListItem.swift
//  The Beer Project - SwiftUI
//
//  Created by nunzio giulio caggegi on 13/09/2019.
//  Copyright © 2019 nunzio giulio caggegi. All rights reserved.
//

import SwiftUI
import URLImage

struct BeerListItem: View {
    
    var beer: Beer
    
    var body: some View {
        HStack {
            URLImage(URL(string: (beer.imageUrl) ?? "https://specsonline.com/wp-content/themes/Specs%20Theme/images/default_beer.jpg") ?? URL(string: "https://specsonline.com/wp-content/themes/Specs%20Theme/images/default_beer.jpg")!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 150, alignment: .center)
            
            VStack {
                Text(beer.name!)
                    .font(.title)
                    .bold()
                Text(beer.description!)
                    .font(.headline)
                    .lineLimit(3)
            }
        }.padding()
    }
}

struct BeerListItem_Previews: PreviewProvider {
    static var previews: some View {
        BeerListItem(beer: SharedMock.shared.getMockBeers().first!)
    }
}
