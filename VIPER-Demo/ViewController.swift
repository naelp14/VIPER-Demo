//
//  ViewController.swift
//  VIPER-testing
//
//  Created by Nathaniel Putera on 11/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(redirectFromSplashScreen), userInfo: nil, repeats: false)
        timer?.fire()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    @objc private func redirectFromSplashScreen() {
        let tabbarController = UITabBarController()
        let homeVC = HomeBuilder.build(navigationController: self.navigationController ?? UINavigationController(rootViewController: self))
        let favVC = FavouritesPageBuilder.build(navigation: self.navigationController ?? UINavigationController(rootViewController: self))
        
        tabbarController.viewControllers = [homeVC, favVC]
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icons8-home-50"), tag: 0)
        favVC.tabBarItem = UITabBarItem(title: "Favourites", image: UIImage(named: "icons8-favourite-50"), tag: 0)
        self.navigationController?.pushViewController(tabbarController, animated: true)
    }


}

