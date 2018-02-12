import UIKit

final class NavVc: UINavigationController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupNav()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupNav()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    private func setupNav() {
        let color = UIColor.white
        
        navigationBar.cs_setup {
            $0.setBackgroundImage(UIImage(), for: .default)
            $0.shadowImage = nil
            $0.isTranslucent = false
            $0.barTintColor = UIColor(red: 82.0/255.0, green: 85.0/255.0, blue: 90.0/255.0, alpha: 1)
            $0.tintColor = color
            $0.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 19, weight: .semibold),
                .foregroundColor: color
            ]
        }
        
        navigationBar.layer.cs_setup {
            $0.masksToBounds = false
            $0.shadowColor = UIColor.black.cgColor
            $0.shadowOpacity = 0.4
            $0.shadowOffset = CGSize(width: 0, height: 1.0)
            $0.shadowRadius = 3
        }
    }
}
