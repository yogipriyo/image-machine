//
//  HomepageViewController.swift
//  ImageMachine
//
//  Created by Yogi Priyo Prayogo on 20/12/22.
//

import UIKit

class HomepageViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        self.navigationItem.title = "Home"
        setupTabbar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.tabBar.tintColor = UIColor.systemBlue
    }
    
    private func setupTabbar() {
        let tabOne = MachineListViewController()
        let tabOneBarItem = UITabBarItem(title: "Machine", image: UIImage(named: "manufacture"), selectedImage: UIImage(named: "selectedImage.png"))
        tabOne.tabBarItem = tabOneBarItem
            
            
        let tabTwo = ScannerViewController()
        let tabTwoBarItem2 = UITabBarItem(title: "Scan QR", image: UIImage(named: "qr-code"), selectedImage: UIImage(named: "selectedImage2.png"))
        tabTwo.tabBarItem = tabTwoBarItem2
            
        self.viewControllers = [tabOne, tabTwo]
    }

}

extension HomepageViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected")
    }
}
