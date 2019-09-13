//
//  SharedMock.swift
//  The Beer Project - SwiftUI
//
//  Created by nunzio giulio caggegi on 13/09/2019.
//  Copyright © 2019 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import SwiftyJSON

public class SharedMock: NSObject {

    private override init() { }

    static let shared = SharedMock()
    
    func getMockBeers() -> [Beer] {
        let path = Bundle.main.path(forResource: "Beers", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let json = JSON(parseJSON: jsonString!).arrayValue
        
        let beers = json.map { (singleJs) -> Beer in
            let finalBeer = Beer.init(singleJs)
            return finalBeer
        }        
        return beers
    }
    
}
