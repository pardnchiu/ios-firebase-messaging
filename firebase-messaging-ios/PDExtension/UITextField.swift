/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UITextField {

	public func text(_ value: String) -> Self { text = value; return self; };

	public func text(placeholder value: String) -> Self { placeholder = value; return self; };

	public func text(secure bool: Bool) -> Self { isSecureTextEntry = bool; return self; };

	var fontName	: String 	{ get { return self.font?.fontName == ".SFUI-Regular" ? "Helvetica" : self.font?.fontName ?? "Helvetica" } };
	
	var fontSize	: CGFloat { get { return self.font?.pointSize ?? UILabel().fontSize } };

	var fontWeight: UIFont.Weight {
		get {
			let descriptor 	= self.font?.fontDescriptor;
			let attributes 	= descriptor?.fontAttributes;
			let fontWeight 	= attributes?[.traits] as? [UIFontDescriptor.TraitKey: Any];
			let weight 			= fontWeight?[.weight] as? CGFloat ?? UIFont.Weight.regular.rawValue;
			return UIFont.Weight(rawValue: weight);
		}
	};

	public func font(_ font: UIFont) -> Self { self.font = font; return self; };

	public func font(name: String?, size: CGFloat?) -> Self {
		if let size = size, let name = name { self.font = UIFont(name: name, size: size) ?? _font; }
		else if let size = size { self.font = UIFont(name: self.fontName, size: size); }
		else if let name = name { self.font = UIFont(name: name, size: self.fontSize) ?? _font; }
		return self;
	};

	public func font(weight: UIFont.Weight?, size: CGFloat?) -> Self {
		if let size = size, let weight = weight { self.font = UIFont.systemFont(ofSize: size, weight: weight); }
		else if let size = size { self.font = UIFont(name: self.fontName, size: size); }
		else if let weight = weight { self.font = UIFont.systemFont(ofSize: self.fontSize, weight: weight); }
		return self;
	};

	public func font(italic size: CGFloat) -> Self { self.font = UIFont.italicSystemFont(ofSize: size); return self; };

	public func font(sizeToFit: Bool) -> Self { self.adjustsFontSizeToFitWidth = sizeToFit; return self; };

	public func view(L: UIView, mode: ViewMode) -> Self { leftView = L; leftViewMode = mode; return self; };

	public func view(R: UIView, mode: ViewMode) -> Self { rightView = R; rightViewMode = mode; return self; };
};
