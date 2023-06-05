//
//  ViewModelBase.swift
//  Arkus
//
//  Created by Roy Quesada on 1/6/23.
//

import Foundation


enum LoadingState {
    case loading, none
}

class ViewModelBase: ObservableObject {
    @Published var loadingState: LoadingState = .none
    
    var httpClient: HTTPClient
    
    init(_ httpClient: HTTPClient){
        self.httpClient = httpClient
    }
}
