//
//  AppDelegate.swift
//  OTPKitDemo
//
//  Created by Aaron Brethorst on 10/30/25.
//

import Foundation
import UIKit
import OSLog

fileprivate let logger = Logger(subsystem: "org.onebusaway.opentrip", category: "app")

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground

        // Check if onboarding has been completed
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")

        logger.info("Setting up window")
        logger.info("Has completed onboarding: \(hasCompletedOnboarding)")

        if hasCompletedOnboarding,
           let serverURL = UserDefaults.standard.url(forKey: "otpServerURL"),
           let regionData = UserDefaults.standard.data(forKey: "selectedRegion"),
           let region = try? JSONDecoder().decode(OTPRegionInfo.self, from: regionData) {
            // Show main OTP view controller
            let mainViewController = OTPDemoViewController(serverURL: serverURL, regionInfo: region)
            let navigationController = UINavigationController(rootViewController: mainViewController)
            window?.rootViewController = navigationController
        } else {
            // Show onboarding
            logger.info("Showing onboarding screen")
            let onboardingVC = OnboardingViewController()
            onboardingVC.onboardingCompleteHandler = { [weak self] serverURL, regionInfo in
                self?.showMainViewController(serverURL: serverURL, regionInfo: regionInfo)
            }
            window?.rootViewController = onboardingVC
        }

        window?.makeKeyAndVisible()
        logger.info("Window is key and visible")

        return true
    }

    private func showMainViewController(serverURL: URL, regionInfo: OTPRegionInfo) {
        let mainViewController = OTPDemoViewController(serverURL: serverURL, regionInfo: regionInfo)
        let navigationController = UINavigationController(rootViewController: mainViewController)

        if let window = window {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = navigationController
            })
        }
    }
}
