//
//  Extensions.swift
//  Market.kz
//
//  Created by admin on 4/6/21.
//

import Foundation
import UIKit


extension UIView{
    var width : CGFloat{
        return frame.size.width
    }
    var height : CGFloat{
        return frame.size.height
    }
    var left : CGFloat{
        return frame.origin.x
    }
    var right : CGFloat{
        return left + width
    }
    var top : CGFloat{
        return frame.origin.y
    }
    var bottom : CGFloat{
        return top + height
    }
}


extension UIImage {
    func tabBarImageWithCustomTint(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!

        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        context.clip(to: rect, mask: self.cgImage!)

        tintColor.setFill()
        context.fill(rect)

        var newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        newImage = newImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        return newImage
    }
}

func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
    guard let window = UIApplication.shared.keyWindow else { return }
    if animated {
        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
            let oldState: Bool = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            window.rootViewController = rootViewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { (finished: Bool) -> () in
            if (completion != nil) {
                completion!()
            }
        })
    } else {
        window.rootViewController = rootViewController
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension UIColor{
   var coreColor : UIColor {
        return UIColor(
        red: 235/255,
        green: 169/255,
        blue: 44/255,
        alpha:0.93)
    }
    var defaultBackground : UIColor {
        return UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIView {
  func addDashedBorder() {
    let color = UIColor.systemBlue.withAlphaComponent(0.8).cgColor

    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 1
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
    }
}

func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage {
    let scale = newHeight / image.size.height
    let newWidth = image.size.width * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage!
}

extension Notification.Name {
    static let updateAds = Notification.Name("updateAds")
}
extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
