//
//  SearchStringObservable.swift
//  The Beer Project - SwiftUI
//
//  Created by Nunzio Giulio Caggegi on 17/09/2019.
//  Copyright © 2019 nunzio giulio caggegi. All rights reserved.
//

import Foundation
import Combine

final class SearchString: ObservableObject {
    public var didChange = PassthroughSubject<String, Never>()
    @Published var string: String = "" {
        didSet {
            didChange.send(string)
        }
    }
}
