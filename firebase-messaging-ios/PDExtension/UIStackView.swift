/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation;
import UIKit;

extension UIStackView {

	public enum __axis { case horz, vert; };

	public enum __alignment { case fill, left, right, center, top, bottom, first, last; };

	public enum __distribution { case fill, fillEq, fillPr, eqCenter, eqSpace; };

	func trans(axis: __axis) -> NSLayoutConstraint.Axis {
		switch axis {
			case .horz: return .horizontal;
			case .vert: return .vertical;
		};
	};

	func trans(align: __alignment) -> Alignment {
		switch align {
			case .fill	: return .fill; 					/* 填滿 */
			case .left	: return .leading; 				/* 靠左 */
			case .right	: return .trailing; 			/* 靠右 */
			case .center: return .center; 				/* 靠中 */
			case .top		: return .top; 						/* 頂部 */
			case .bottom: return .bottom; 				/* 底部 */
			case .first	: return .firstBaseline; 	/* 首行 */
			case .last	: return .lastBaseline; 	/* 尾行 */
		};
	};

	func trans(fill: __distribution) -> Distribution {
		switch fill {
			case .fill	  : return .fill; 								/* 填滿空間 */
			case .fillEq  : return .fillEqually; 				/* 填滿並平均分配空間 */
			case .fillPr  : return .fillProportionally; 	/* 填滿並依比例分配空間 */
			case .eqCenter: return.equalCentering; 			/* 填充空間並相同間距 */
			case .eqSpace : return .equalSpacing; 				/* 填充空間並相同中心間距 */
		};
	};

	convenience public init(axis: __axis, align: __alignment) { self.init(); self.axis = trans(axis: axis); self.alignment = trans(align: align); };

	convenience public init(axis: __axis, align: __alignment, gap: CGFloat) { self.init(); self.axis = trans(axis: axis); self.alignment = trans(align: align); self.spacing = gap; };

	convenience public init(axis: __axis, align: __alignment, fill: __distribution) { self.init(); self.axis = trans(axis: axis); self.alignment = trans(align: align); self.distribution = trans(fill: fill); };

	convenience public init(axis: __axis, align: __alignment, fill: __distribution, gap: CGFloat) { self.init(); self.axis = trans(axis: axis); self.alignment = trans(align: align); self.distribution = trans(fill: fill); self.spacing = gap; };
}

extension UIStackView {

	public func padding(vert: CGFloat, horz: CGFloat) -> Self {
		self.isLayoutMarginsRelativeArrangement = true;
		self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: vert, leading: horz, bottom: vert, trailing: horz);
		return self;
	};

	public func padding(horz: CGFloat) -> Self {
		let t: CGFloat = self.directionalLayoutMargins.top;
		let b: CGFloat = self.directionalLayoutMargins.bottom;
		self.isLayoutMarginsRelativeArrangement = true;
		self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: t, leading: horz, bottom: b, trailing: horz);
		return self;
	};

	public func padding(T: CGFloat) -> Self {
		let l: CGFloat = self.directionalLayoutMargins.leading;
		let b: CGFloat = self.directionalLayoutMargins.bottom;
		let r: CGFloat = self.directionalLayoutMargins.trailing;
		self.isLayoutMarginsRelativeArrangement = true;
		self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: T, leading: l, bottom: b, trailing: r);
		return self;
	};

	public func padding(L: CGFloat) -> Self {
		let t: CGFloat = self.directionalLayoutMargins.top;
		let b: CGFloat = self.directionalLayoutMargins.bottom;
		let r: CGFloat = self.directionalLayoutMargins.trailing;
		self.isLayoutMarginsRelativeArrangement = true;
		self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: t, leading: L, bottom: b, trailing: r);
		return self;
	};

	public func padding(R: CGFloat) -> Self {
		let t: CGFloat = directionalLayoutMargins.top;
		let l: CGFloat = directionalLayoutMargins.leading;
		let b: CGFloat = directionalLayoutMargins.bottom;
		self.isLayoutMarginsRelativeArrangement = true;
		self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: t, leading: l, bottom: b, trailing: R);
		return self;
	};

	public func padding(B: CGFloat) -> Self {
		let t: CGFloat = self.directionalLayoutMargins.top;
		let l: CGFloat = self.directionalLayoutMargins.leading;
		let r: CGFloat = self.directionalLayoutMargins.trailing;
		self.isLayoutMarginsRelativeArrangement = true;
		self.directionalLayoutMargins = NSDirectionalEdgeInsets(top: t, leading: l, bottom: B, trailing: r);
		return self;
	};

	override public func child(_ views: [UIView]) -> Self { views.forEach { self.addArrangedSubview($0); }; return self; };
	public func child(unsort views: [UIView]) -> Self { views.forEach { self.addSubview($0); }; return self; };
};
