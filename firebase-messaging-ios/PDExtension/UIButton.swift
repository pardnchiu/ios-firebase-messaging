/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UIButton {

	public func bg(image: UIImage?, mode: UIView.ContentMode) -> Self { var new = conf; new.background.image = image; new.background.imageContentMode = mode; self.conf = new; return self; };

	public func bg(image: UIImage?, color: UIColor, mode: UIView.ContentMode) -> Self { var new = conf; new.background.image = image?.withTintColor(color, renderingMode: .alwaysOriginal); new.background.imageContentMode = mode; self.conf = new; return self; };

	var conf: UIButton.Configuration {
		get {
			{ (conf: UIButton.Configuration) in
				return conf;
			}({
				if let conf = self.configuration { return conf; }
				else { return UIButton.Configuration.plain(); }
			}());
		}
		set {
			self.configuration = newValue;
		}
	};

	public func text(color: UIColor?) -> Self {
		var new = conf;
		if let color = color { new.baseForegroundColor = color; };
		self.conf = new;
		return self;
	};

	public func text(_ text: String, color: UIColor?) -> Self {
		var new = conf;
		new.title = text;
		if let color = color { new.baseForegroundColor = color; };
		self.conf = new;
		return self;
	};

	public func font(_ font: UIFont?) -> Self {
		var new = conf;
		new.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { e in
			var config = e;
			config.font = font;
			return config
		};
		self.conf = new;
		return self;
	};

	public func font(weight: UIFont.Weight?, size: CGFloat?) -> Self {
		if let size = size, let weight = weight { _=self.font(UIFont.systemFont(ofSize: size, weight: weight)); }
		else if let size = size { _=self.font(UIFont.systemFont(ofSize: size, weight: self.titleLabel?.fontWeight ?? .regular)); }
		else if let weight = weight { _=self.font(UIFont.systemFont(ofSize: self.titleLabel?.fontSize ?? _fontSize, weight: weight)); }
		return self;
	};

	public enum __img_align { case top, left, bottom, right; };

	public func img(_ img: UIImage?) -> Self { var new = conf; new.image = img ?? _image; self.conf = new; return self; };

	public func img(_ img: UIImage?, align: __img_align, gap: CGFloat) -> Self {
		var new = conf;
		new.image = img ?? _image;
		switch align {
			case .top		: new.imagePlacement = .top;
			case .left	: new.imagePlacement = .leading;
			case .bottom: new.imagePlacement = .bottom;
			case .right	: new.imagePlacement = .trailing;
		};
		new.imagePadding = gap;
		self.conf = new;
		return self;
	};

	public func padding(_ val: CGFloat) -> Self { var new = conf; new.contentInsets = NSDirectionalEdgeInsets(top: val, leading: val, bottom: val, trailing: val); self.conf = new; return self; };
	
	public func touch(down: Any,_ action: Selector) -> Self { self.addTarget(down, action: action, for: .touchDown); return self; };
};
