import UIKit
import AVKit

final class VidsVc: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UI.Layout.collectionL)
    private var objs: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.addTo(view).cs_setup {
            $0.connectSV()
            $0.backgroundColor = .clear
            $0.alwaysBounceVertical = true
            $0.register(VidCell.self, forCellWithReuseIdentifier: UI.Text.titleCellId)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let c = try? FileManager.default.contentsOfDirectory(atPath: dir.absoluteString)
        self.objs = c ?? [RKRecorderFileUtils.path("video6")]
        collectionView.reloadData()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UI.Text.titleCellId, for: indexPath) as! VidCell
        cell.configure(objs[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = objs[indexPath.row]
        let url = URL(fileURLWithPath: obj)
        let player = AVPlayer(url: url)
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true, completion: nil)
    }

}

private class VidCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.addTo(contentView).cs_setup {
            $0.connectCH(contentView).connectLeft(contentView, 12).connectRight(contentView, -12)
            $0.textColor = UIColor(red: 82.0/255.0, green: 85.0/255.0, blue: 90.0/255.0, alpha: 1)
            $0.textAlignment = .left
        }
        
        UIView().addTo(contentView).cs_setup {
            $0.connectBottom(contentView).connectLeft(contentView, 12).connectRight(contentView, 12).connectHeight(0.5)
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}

private enum UI {
    enum Text {
        static let titleCellId = "titleCellId"
    }
    
    enum Layout {
        static var collectionL: UICollectionViewLayout {
            let l = UICollectionViewFlowLayout()
            l.scrollDirection = .vertical
            return l
        }
    }
}
