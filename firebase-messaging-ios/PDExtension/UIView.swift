/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation;
import UIKit;

extension UIView {

	@objc convenience public init(_ x: CGFloat,_ y: CGFloat,_ width: CGFloat,_ height: CGFloat) { self.init(frame: CGRect(x, y, width, height)); };

	public func frame(_ x: CGFloat,_ y: CGFloat,_ width: CGFloat,_ height: CGFloat) -> Self { self.frame = CGRect(x, y, width, height); return self; };

	public func alpha(_ alpha: CGFloat)  -> Self { self.alpha = alpha; return self; };

	@objc public func radius(_ radius: CGFloat) -> Self { self.layer.cornerRadius = radius; return self; };

	public func clip(view bool: Bool) -> Self { self.clipsToBounds = bool; return self; };

	@objc public func bg(color: UIColor) -> Self { self.backgroundColor = color; return self; };

	@objc public func bg(image: UIImage?) -> Self { self.backgroundColor = UIColor(patternImage: image ?? _image); return self; };

	public func shadow(color: UIColor, alpha: Float, blur: CGFloat, x: CGFloat, y: CGFloat) -> Self { self.layer.shadowColor = color.cgColor; self.layer.shadowOpacity = alpha; self.layer.shadowRadius = blur; self.layer.shadowOffset = CGSize(x, y); return self; };

	@objc public func child(_ views: [UIView]) -> Self { views.forEach { self.addSubview($0); }; return self; };

	@objc public func layer(_ layers: [CALayer]) -> Self { layers.forEach { self.layer.addSublayer($0); }; return self; };

	public func draw(_ width: CGFloat,_ height: CGFloat,_ completion: @escaping (UIImage?) -> Void) {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
		self.drawHierarchy(in: CGRect(x: 0, y: 0, width: width, height: height), afterScreenUpdates: true)
		if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
			UIGraphicsEndImageContext()
			completion(image)
		} else {
			completion(nil)
		}
	};

	public func tap(target: Any?,_ taps: Int,_ touches: Int,_ selector: Selector?) -> Self {
		let tap = UITapGestureRecognizer(target: target, action: selector)._ {
			$0.numberOfTapsRequired    = taps;
			$0.numberOfTouchesRequired = touches;
		};
		self.addGestureRecognizer(tap);
		return self;
	};
};

