//
//  View+Extensions.swift
//  Arkus
//
//  Created by Roy Quesada on 2/6/23.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
