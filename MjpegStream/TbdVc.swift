import UIKit

final class TbdVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UILabel().addTo(view).cs_setup {
            $0.connectCH(view).connectCV(view)
            $0.textColor = UIColor.black.withAlphaComponent(0.3)
            $0.font = UIFont.systemFont(ofSize: 55, weight: .bold)
            $0.textAlignment = .center
            $0.text = "Att vara klar."
        }
    }

}
