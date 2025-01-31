import ProjectDescription
import Foundation

public struct ExternalPackages {
  
  public struct DataLayer {
    public static var Alamofire: TargetDependency {
      return .package(product: "Alamofire", type: .runtime)
    }
  }
  
  public struct PresentationLayer {
    public static var Shimmer: TargetDependency {
      return .package(product: "Shimmer", type: .runtime)
    }
    
    public static var Confetti: TargetDependency {
      return .package(product: "ConfettiSwiftUI", type: .runtime)
    }
    
    public static var Lottie: TargetDependency {
      return .package(product: "Lottie", type: .runtime)
    }
    
    public static var ToastUI: TargetDependency {
      return .package(product: "ToastUI", type: .runtime)
    }
  }
  
  public struct Google {
    
    public struct Firebase {
      public static var Core: TargetDependency {
        return .package(product: "FirebaseCore", type: .runtime)
      }
      
      public static var Analytics: TargetDependency {
        return .package(product: "FirebaseAnalytics", type: .runtime)
      }
      
      public static var Crashlytics: TargetDependency {
        return .package(product: "FirebaseCrashlytics", type: .runtime)
      }
    }
    
    public static var MobileAds: TargetDependency {
      return .package(product: "GoogleMobileAds", type: .runtime)
    }
    
  }
}
