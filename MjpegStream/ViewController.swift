import UIKit

// MARK: - ViewController -

final class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Property
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UI.Layout.collectionL)
    private let sections = CameraSection.all
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cs_setup {
            $0.navigationItem.title = UI.Text.title
            $0.view.backgroundColor = UI.Color.light
        }
        
        collectionView.addTo(view).cs_setup {
            $0.connectSV()
            $0.backgroundColor = .clear
            $0.alwaysBounceVertical = true
            $0.register(TitleCell.self, forCellWithReuseIdentifier: UI.Text.titleCellId)
            $0.register(CameraCell.self, forCellWithReuseIdentifier: UI.Text.cameraCellId)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].cameras.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UI.Text.titleCellId, for: indexPath) as! TitleCell
            cell.configure(text: section.title)
            return cell
        }
        
        let camera = section.cameras[indexPath.row - 1]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UI.Text.cameraCellId, for: indexPath) as! CameraCell
        cell.configure(camera: camera)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: indexPath.row == 0 ? 25 : 55)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        
        let section = sections[indexPath.section]
        let camera = section.cameras[indexPath.row - 1]
        
        IJKVideoViewController.present(from: self,
                                       withTitle: camera.title,
                                       url: URL(string: camera.url),
                                       completion: {})
    }
    
    // MARK: CameraCell
    
    private final class CameraCell: UICollectionViewCell {
        private let titleLabel = UILabel()
        private let urlLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            let m = UI.Layout.m
            let s = UI.Layout.iconSide
            
            let iv = UIImageView().addTo(contentView).cs_setup {
                $0.connectRight(contentView, -m).connectCH(contentView).connectHeight(s).connectWidth(s)
                $0.contentMode = .scaleAspectFit
                $0.image = UIImage(icon: .FAChevronRight,
                                   size: CGSize(width: s, height: s),
                                   textColor: UI.Color.dark.withAlphaComponent(0.7),
                                   backgroundColor: .clear)
            }
            
            let container = UIView().addTo(contentView).cs_setup {
                $0.connectLeft(contentView, m).connectPrev(iv, -m).connectCH(contentView)
            }
            
            titleLabel.addTo(container).cs_setup {
                $0.connectLeft(container).connectRight(container).connectTop(container)
                $0.font = UI.Font.cameraTitleFont
                $0.textColor = UI.Color.dark
                $0.textAlignment = .left
            }
            
            urlLabel.addTo(container).cs_setup {
                $0.connectLeft(container).connectRight(container).connectBottom(container).connectUnder(titleLabel, 4)
                $0.font = UI.Font.cameraSubtitleFont
                $0.textColor = UI.Color.dark
                $0.textAlignment = .left
            }
            
            UIView().addTo(contentView).cs_setup {
                $0.connectLeft(contentView, m).connectRight(contentView, -m).connectBottom(contentView).connectHeight(0.5)
                $0.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            }
        }
        
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
        func configure(camera: Camera) {
            titleLabel.text = camera.title
            urlLabel.text = camera.url
        }
    }
    
    private final class TitleCell: UICollectionViewCell {
        private let titleLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            let m = UI.Layout.m
            
            contentView.backgroundColor = UI.Color.dark
            
            titleLabel.addTo(contentView).cs_setup {
                $0.connectLeft(contentView, m).connectRight(contentView, -m).connectCH(contentView)
                $0.font = UI.Font.titleFont
                $0.textColor = UIColor.white
                $0.textAlignment = .left
            }
        }
        
        func configure(text: String) {
            titleLabel.text = text
        }
        
        required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    }
}

// MARK: - UI -

private enum UI {
    enum Text {
        static let cameraCellId = "cameraCellId"
        static let titleCellId = "titleCellId"
        static let title = "Kamerans lista"
    }
    
    enum Layout {
        static let m: CGFloat = 12
        static let iconSide: CGFloat = 20
        static var collectionL: UICollectionViewLayout {
            let l = UICollectionViewFlowLayout()
            l.scrollDirection = .vertical
            return l
        }
    }
    
    enum Font {
        static let titleFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
        static let cameraTitleFont = UIFont.systemFont(ofSize: 15, weight: .semibold)
        static let cameraSubtitleFont = UIFont.systemFont(ofSize: 9, weight: .regular)
    }
    
    enum Color {
        static let dark = UIColor(red: 82.0/255.0, green: 85.0/255.0, blue: 90.0/255.0, alpha: 1)
        static let light = UIColor(red: 0.95, green: 0.93, blue: 0.9, alpha: 1)
    }
}

// MARK: - Entity -

struct CameraSection {
    let title: String
    let cameras: [Camera]
    
    static let all: [CameraSection] = [
        CameraSection(title: "Högsta prioritet", cameras: Camera.all),
        CameraSection(title: "Nya order", cameras: Camera.all2)
    ]
}

struct Camera {
    let title: String
    let url: String
    
    static let all: [Camera] = [
        Camera(title: "Order #34",
               url: "http://devimages.apple.com/iphone/samples/bipbop/gear4/prog_index.m3u8"),
        Camera(title: "Problem 2.542",
               url: "http://bbcwshdlive01-lh.akamaihd.net/i/atv_1@61433/master.m3u8"),
        Camera(title: "Problem 4.1",
               url: "http://newsx.live-s.cdn.bitgravity.com/cdn-live/_definst_/newsx/live/newsxnew.smil/playlist.m3u8"),
        Camera(title: "Hjälpförfrågan 8/342",
               url: "http://app.pakistanvision.tv:1935/live/8090/player.m3u8"),
        Camera(title: "Order #12",
               url: "http://63.237.48.23/ios/IRIB_MOSTANAD/IRIB_MOSTANAD.m3u8"),
        Camera(title: "Brådskande!! #4",
               url: "http://il28.cast-tv.com:1935/23595_LIVE_Kotel_Live/_definst_//23595_LIVE_Kotel_Live/playlist.m3u8")
    ]
    
    static let all2: [Camera] = [
        Camera(title: "Order #39",
               url: "http://184.72.239.149/vod/smil:BigBuckBunny.smil/playlist.m3u8"),
        Camera(title: "Problem 2.542",
               url: "http://www.streambox.fr/playlists/test_001/stream.m3u8"),
        Camera(title: "Problem 3.85",
               url: "http://devimages.apple.com/iphone/samples/bipbop/gear4/prog_index.m3u8")
    ]
}
