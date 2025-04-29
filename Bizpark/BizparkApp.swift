import SwiftUI

@main
struct BizparkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            RemoteScreen()
        }
    }
}
