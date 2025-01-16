import SwiftUI

import Main
import Factories

@main
struct SurchargesApp: App {
	var body: some Scene {
		WindowGroup {
			NavigationStack {
				MainView(viewModel: MainFactory.resolve())
			}
		}
	}
}
