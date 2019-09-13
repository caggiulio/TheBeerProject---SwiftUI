//
//  HomeViewModel.swift
//  The Beer Project - SwiftUI
//
//  Created by nunzio giulio caggegi on 13/09/2019.
//  Copyright © 2019 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import PromiseKit

public class HomeViewModel: ObservableObject {
    public let objectWillChange = ObservableObjectPublisher()
    public var didChange = PassthroughSubject<HomeViewModel, Never>()
    public var page = 1
    
    @Published var beers = [Beer]() {
        didSet {
            //objectWillChange.send() send a signal to the Subscriber, and he must use homeViewModel.beers to read
            self.objectWillChange.send()
            //didChange.send(self) send all homeViewModel object. The Subscriber can read in his class all the field of the Pubisher
            self.didChange.send(self)
        }
    }
    
    init() {
        getBeers(page: page, beerName: "", category: "")
    }
    
    func getBeers(page: Int, beerName: String, category: String) {
        firstly {
            API().getBeers(page: page, beerName: beerName, category: category)
        }.map { (json) -> [Beer] in
            let beers = json.arrayValue.map { (singleJs) -> Beer in
                return Beer(singleJs)
            }
            return beers
        }.done { (beers) in
            self.beers += beers
            self.page += 1
            print("next page will be \(self.page)")
        }.catch { (error) in
            print(error)
        }
    }
}
