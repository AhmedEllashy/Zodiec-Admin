//
//  Zodiec_AdminApp.swift
//  Zodiec Admin
//
//  Created by Ahmad Ellashy on 27/12/2023.
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Zodiec_AdminApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            OrdersView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
