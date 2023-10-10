/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UITextView {

	public func proto(_ del: UITextViewDelegate) -> Self { self.delegate = del; return self; };

	public func text(_ value: String, color: UIColor, align: NSTextAlignment) -> Self { text = value; textColor = color; textAlignment = align; return self; };

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

	public func font(_ value: UIFont) -> Self { self.font = value; return self; };

	public func font(name: String?, size: CGFloat?) -> Self {
		if let size = size, let name = name { font = UIFont(name: name, size: size) ?? _font; }
		else if let size = size { font = UIFont(name: fontName, size: size); }
		else if let name = name { font = UIFont(name: name, size: fontSize) ?? _font; }
		return self;
	};

	public func font(weight: UIFont.Weight?, size: CGFloat?) -> Self {
		if let size = size, let weight = weight { self.font = UIFont.systemFont(ofSize: size, weight: weight); }
		else if let size = size { self.font = UIFont(name: self.fontName, size: size); }
		else if let weight = weight { self.font = UIFont.systemFont(ofSize: self.fontSize, weight: weight); }
		return self;
	};

	public func font(italic size: CGFloat) -> Self { self.font = UIFont.italicSystemFont(ofSize: size); return self; };

	public func padding(_ top: CGFloat,_ left: CGFloat,_ bottom: CGFloat,_ right: CGFloat) -> Self { contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right); return self; };

	public func padding(val: CGFloat) -> Self { contentInset = UIEdgeInsets(top: val, left: val, bottom: val, right: val); return self; };

	public func padding(vert: CGFloat, horz: CGFloat) -> Self { contentInset = UIEdgeInsets(top: vert, left: horz, bottom: vert, right: horz); return self; };

	public func padding(vert: CGFloat) -> Self { contentInset = UIEdgeInsets(top: vert, left: contentInset.left, bottom: vert, right: contentInset.right); return self; };

	public func padding(horz: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: horz, bottom: contentInset.bottom, right: horz); return self; };

	public func padding(T: CGFloat) -> Self { contentInset = UIEdgeInsets(top: T, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right); return self; };

	public func padding(L: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: L, bottom: contentInset.bottom, right: contentInset.right); return self; };

	public func padding(B: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: B, right: contentInset.right); return self; };

	public func padding(R: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: contentInset.bottom, right: R); return self; };
};
