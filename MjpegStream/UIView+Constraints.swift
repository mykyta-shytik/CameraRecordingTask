import UIKit
import PureLayout

public protocol CryptoCustomizable {}
extension NSObject: CryptoCustomizable {}
extension CryptoCustomizable {
    @discardableResult func cs_setup(_ block: (Self) -> Void) -> Self { block(self); return self }
}

extension UIView {
    
    // MARK: - Connect z-neighbours
    
    // Left
    
    @discardableResult
    func connectLeft(_ leftView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.leading, to: .leading, of: leftView, withOffset: offset); return self
    }
    func connectedLeft(_ leftView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.leading, to: .leading, of: leftView, withOffset: offset)
    }
    
    // Right
    
    @discardableResult
    func connectRight(_ rightView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.trailing, to: .trailing, of: rightView, withOffset: offset); return self
    }
    func connectedRight(_ rightView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.trailing, to: .trailing, of: rightView, withOffset: offset)
    }
    
    // Top
    
    @discardableResult
    func connectTop(_ topView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.top, to: .top, of: topView, withOffset: offset); return self
    }
    func connectedTop(_ topView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.top, to: .top, of: topView, withOffset: offset)
    }
    
    // Bottom
    
    @discardableResult
    func connectBottom(_ bottomView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.bottom, to: .bottom, of: bottomView, withOffset: offset); return self
    }
    func connectedBottom(_ bottomView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.bottom, to: .bottom, of: bottomView, withOffset: offset)
    }
    
    // MARK: - Connect xy-neighbours
    
    // Next
    
    @discardableResult
    func connectNext(_ leftView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.leading, to: .trailing, of: leftView, withOffset: offset); return self
    }
    func connectedNext(_ leftView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.leading, to: .leading, of: leftView, withOffset: offset)
    }
    
    // Prev
    
    @discardableResult
    func connectPrev(_ rightView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.trailing, to: .leading, of: rightView, withOffset: offset); return self
    }
    func connectedPrev(_ rightView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.trailing, to: .leading, of: rightView, withOffset: offset)
    }
    
    // Under
    
    @discardableResult
    func connectUnder(_ topView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.top, to: .bottom, of: topView, withOffset: offset); return self
    }
    func connectedUnder(_ topView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.top, to: .bottom, of: topView, withOffset: offset)
    }
    
    // Above
    
    @discardableResult
    func connectAbove(_ bottomView: UIView, _ offset: CGFloat = 0) -> Self {
        autoPinEdge(.bottom, to: .top, of: bottomView, withOffset: offset); return self
    }
    func connectedAbove(_ bottomView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoPinEdge(.bottom, to: .top, of: bottomView, withOffset: offset)
    }
    
    // MARK: - Centering
    
    // Vertical
    
    @discardableResult
    func connectCV(_ centerView: UIView, _ offset: CGFloat = 0) -> Self {
        autoAlignAxis(.vertical, toSameAxisOf: centerView, withOffset: offset); return self
    }
    func connectedCV(_ centerView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoAlignAxis(.vertical, toSameAxisOf: centerView, withOffset: offset)
    }
    
    // Horizontal
    
    @discardableResult
    func connectCH(_ centerView: UIView, _ offset: CGFloat = 0) -> Self {
        autoAlignAxis(.horizontal, toSameAxisOf: centerView, withOffset: offset); return self
    }
    func connectedCH(_ centerView: UIView, _ offset: CGFloat = 0) -> NSLayoutConstraint {
        return autoAlignAxis(.horizontal, toSameAxisOf: centerView, withOffset: offset)
    }
    
    // Horizontal + vertical
    
    @discardableResult
    func connectCHV(_ centerView: UIView, _ hOffset: CGFloat = 0, _ vOffset: CGFloat = 0) -> Self {
        return connectCH(centerView, hOffset).connectCV(centerView, vOffset)
    }
    func connectedCHV(_ centerView: UIView, _ hOffset: CGFloat = 0, _ vOffset: CGFloat = 0) -> [NSLayoutConstraint] {
        return [connectedCH(centerView, hOffset), connectedCV(centerView, vOffset)]
    }
    
    // MARK: - Sizing
    
    // Height
    
    @discardableResult
    func connectHeight(_ value: CGFloat) -> Self {
        autoSetDimension(.height, toSize: value); return self
    }
    func connectedHeight(_ value: CGFloat) -> NSLayoutConstraint {
        return autoSetDimension(.height, toSize: value)
    }
    
    // Width
    
    @discardableResult
    func connectWidth(_ value: CGFloat) -> Self {
        autoSetDimension(.width, toSize: value); return self
    }
    func connectedWidth(_ value: CGFloat) -> NSLayoutConstraint {
        return autoSetDimension(.width, toSize: value)
    }
    
    // Ratio H2W
    
    @discardableResult
    func connectH2W(_ ratio: CGFloat = 1) -> Self {
        autoMatch(.height, to: .width, of: self, withMultiplier: ratio); return self
    }
    func connectedH2W(_ ratio: CGFloat = 1) -> NSLayoutConstraint {
        return autoMatch(.height, to: .width, of: self, withMultiplier: ratio)
    }
    
    // Ratio W2H
    
    @discardableResult
    func connectW2H(_ ratio: CGFloat = 1) -> Self {
        autoMatch(.width, to: .height, of: self, withMultiplier: ratio); return self
    }
    func connectedW2H(_ ratio: CGFloat = 1) -> NSLayoutConstraint {
        return autoMatch(.width, to: .height, of: self, withMultiplier: ratio)
    }
    
    // MARK: - Full connect
    
    @discardableResult func connectSV(t: CGFloat, r: CGFloat, b: CGFloat, l: CGFloat) -> Self  {
        autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: t, left: l, bottom: b, right: r)); return self
    }
    @discardableResult func connectSV() -> Self { autoPinEdgesToSuperviewEdges(); return self }
    @discardableResult func addTo(_ sv: UIView) -> Self { sv.addSubview(self); return self }
    @discardableResult func follow(_ fV: UIView) -> Self { return connectTop(fV).connectBottom(fV).connectLeft(fV).connectRight(fV) }
    @discardableResult func addAndConnect(_ sv: UIView) -> Self { return addTo(sv).connectSV() }
    
    @discardableResult func addToVc(_ vc: UIViewController) -> Self {
        addTo(vc.view).connectLeft(vc.view).connectRight(vc.view)
        autoPin(toTopLayoutGuideOf: vc, withInset: 0)
        autoPin(toBottomLayoutGuideOf: vc, withInset: 0)
        return self
    }
}
