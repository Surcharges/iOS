import SwiftUI

import Main
import Factories

@main
struct SurchargesApp: App {
	var body: some Scene {
		WindowGroup {
			MainView(viewModel: MainFactory.resolve())
		}
	}
}
