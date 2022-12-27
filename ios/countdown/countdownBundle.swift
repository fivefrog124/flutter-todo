//
//  countdownBundle.swift
//  countdown
//
//  Created by Kerem İriş on 23.12.2022.
//

import WidgetKit
import SwiftUI

@main
struct countdownBundle: WidgetBundle {
    var body: some Widget {
        countdown()
        countdownLiveActivity()
    }
}
