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
import Alamofire

public class HomeViewModel: ObservableObject {
    public let objectWillChange = ObservableObjectPublisher()
    public var didChange = PassthroughSubject<HomeViewModel, Never>()
    public var page = 1
    public var searchText: String = "" {
        didSet {
            Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
                tasks.forEach { $0.cancel()}
            }
            self.beers.removeAll()
            self.page = 1
            self.getBeers(page: self.page, beerName: searchText, category: "")
        }
    }
    
    @Published var beers = [Beer]() {
        didSet {
            //objectWillChange.send() send a signal to the Subscriber, and he must use homeViewModel.beers to read
            self.objectWillChange.send()
            //didChange.send(self) send all homeViewModel object. The Subscriber can read in his class all the field of the Pubisher
            self.didChange.send(self)
        }
    }
    
    init() {
        getBeers(page: page, beerName: searchText, category: "")
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
        }.catch { (error) in
            print(error)
        }
    }
}
