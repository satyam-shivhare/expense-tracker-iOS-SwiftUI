//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 01/04/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transanctionListVM = TransanctionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transanctionListVM)
        }
    }
}
