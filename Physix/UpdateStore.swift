//
//  UpdateStore.swift
//  newStart
//
//  Created by Orestis Vaggelis on 17/8/20.
//  Copyright © 2020 Orestis Vaggelis. All rights reserved.
//

import SwiftUI
import Combine

class UpdateStore: ObservableObject{
    @Published var updates: [Update] = updateData
}


