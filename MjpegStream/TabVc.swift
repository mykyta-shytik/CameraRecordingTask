//
//  TabVc.swift
//  MjpegStream
//
//  Created by Mykyta Shytik on 2/9/18.
//  Copyright © 2018 ModuleSoftware. All rights reserved.
//

import UIKit

class TabVc: UITabBarController {
    
    // MARK: Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.viewControllers = self.vcs()
        self.tabBar.barTintColor = UIColor(red: 82.0/255.0, green: 85.0/255.0, blue: 90.0/255.0, alpha: 1)
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = UIColor.white.withAlphaComponent(0.5)
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 10, weight: .semibold), .kern: 1], for: .normal)
        
        tabBar.layer.cs_setup {
            $0.masksToBounds = false
            $0.shadowColor = UIColor.black.cgColor
            $0.shadowOpacity = 0.4
            $0.shadowOffset = CGSize(width: 0, height: -1.0)
            $0.shadowRadius = 3
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: Private (setup)
    
    private func vcs() -> [UIViewController] {
        let vc1 = ViewController()
        let nav1 = NavVc(rootViewController: vc1)
        let image1 = UIImage(icon: .FACameraRetro, size: iconSize, textColor: .black, backgroundColor: .clear)
        nav1.tabBarItem = UITabBarItem(title: "Kameror", image: image1, selectedImage: nil)
        
        let vc2 = TbdVc()
        vc2.view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1)
        vc2.navigationItem.title = "Filer"
        let nav2 = NavVc(rootViewController: vc2)
        let image2 = UIImage(icon: .FAFile, size: iconSize, textColor: .black, backgroundColor: .clear)
        nav2.tabBarItem = UITabBarItem(title: "Filer", image: image2, selectedImage: nil)
        
        let vc3 = TbdVc()
        vc3.view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1)
        vc3.navigationItem.title = "Meddelanden"
        let nav3 = NavVc(rootViewController: vc3)
        let image3 = UIImage(icon: .FAInbox, size: iconSize, textColor: .black, backgroundColor: .clear)
        nav3.tabBarItem = UITabBarItem(title: "Meddelanden", image: image3, selectedImage: nil)
        
        let vc4 = TbdVc()
        vc4.view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1)
        vc4.navigationItem.title = "Nyheter"
        let nav4 = NavVc(rootViewController: vc4)
        let image4 = UIImage(icon: .FAFeed, size: iconSize, textColor: .black, backgroundColor: .clear)
        nav4.tabBarItem = UITabBarItem(title: "Nyheter", image: image4, selectedImage: nil)
        
        let vc5 = TbdVc()
        vc5.view.backgroundColor = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1)
        vc5.navigationItem.title = "Inställningar"
        let nav5 = NavVc(rootViewController: vc5)
        let image5 = UIImage(icon: .FAGears, size: iconSize, textColor: .black, backgroundColor: .clear)
        nav5.tabBarItem = UITabBarItem(title: "Inställningar", image: image5, selectedImage: nil)
        
        return [nav1, nav2, nav3, nav4, nav5]
    }
    
    private var iconSize: CGSize { return CGSize(width: 30, height: 30) }

}
