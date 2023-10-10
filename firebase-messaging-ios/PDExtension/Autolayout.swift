/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

// MARK: Autolayout 擴展
extension NSLayoutXAxisAnchor {
	func eq(_ anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint { return self.constraint(equalTo: anchor) };
	func ge(_ anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualTo: anchor) };
	func le(_ anchor: NSLayoutXAxisAnchor) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualTo: anchor) };

	func eq(_ anchor: NSLayoutXAxisAnchor,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(equalTo: anchor, constant: val) };
	func ge(_ anchor: NSLayoutXAxisAnchor,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualTo: anchor, constant: val) };
	func le(_ anchor: NSLayoutXAxisAnchor,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualTo: anchor, constant: val) };
};

extension NSLayoutYAxisAnchor {
	func eq(_ anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint { return self.constraint(equalTo: anchor) };
	func ge(_ anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualTo: anchor) };
	func le(_ anchor: NSLayoutYAxisAnchor) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualTo: anchor) };

	func eq(_ anchor: NSLayoutYAxisAnchor,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(equalTo: anchor, constant: val) };
	func ge(_ anchor: NSLayoutYAxisAnchor,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualTo: anchor, constant: val) };
	func le(_ anchor: NSLayoutYAxisAnchor,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualTo: anchor, constant: val) };
};

extension NSLayoutDimension {
	func eq(_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(equalToConstant: val) };
	func ge(_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualToConstant: val) };
	func le(_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualToConstant: val) };

	func eq(_ anchor: NSLayoutDimension) -> NSLayoutConstraint { return self.constraint(equalTo: anchor) };
	func ge(_ anchor: NSLayoutDimension) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualTo: anchor) };
	func le(_ anchor: NSLayoutDimension) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualTo: anchor) };

	func eq(_ anchor: NSLayoutDimension,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(equalTo: anchor, constant: val) };
	func ge(_ anchor: NSLayoutDimension,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(greaterThanOrEqualTo: anchor, constant: val) };
	func le(_ anchor: NSLayoutDimension,_ val: CGFloat) -> NSLayoutConstraint { return self.constraint(lessThanOrEqualTo: anchor, constant: val) };
};

extension UIView {

	// MARK: 快速取值
	var lytX: NSLayoutXAxisAnchor { get { return self.centerXAnchor } };
	var lytL: NSLayoutXAxisAnchor { get { return self.leftAnchor } };
	var lytR: NSLayoutXAxisAnchor { get { return self.rightAnchor } };

	var lytY: NSLayoutYAxisAnchor { get { return self.centerYAnchor } };
	var lytT: NSLayoutYAxisAnchor { get { return self.topAnchor } };
	var lytB: NSLayoutYAxisAnchor { get { return self.bottomAnchor } };

	var lytW: NSLayoutDimension { get { return self.widthAnchor } };
	var lytH: NSLayoutDimension { get { return self.heightAnchor } };

	// MARK: Equal
	func autolayout(_ bool: Bool) -> Self { self.translatesAutoresizingMaskIntoConstraints = !bool; return self; };

	public func Xeq(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.eq(anchor.lytX, val).isActive = true; return self; };
	public func Xeq(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.eq(anchor.lytL, val).isActive = true; return self; };
	public func Xeq(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.eq(anchor.lytR, val).isActive = true; return self; };

	public func Leq(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.eq(anchor.lytX, val).isActive = true; return self; };
	public func Leq(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.eq(anchor.lytL, val).isActive = true; return self; };
	public func Leq(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.eq(anchor.lytR, val).isActive = true; return self; };

	public func Req(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.eq(anchor.lytX, val).isActive = true; return self; };
	public func Req(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.eq(anchor.lytL, val).isActive = true; return self; };
	public func Req(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.eq(anchor.lytR, val).isActive = true; return self; };

	public func Yeq(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.eq(anchor.lytY, val).isActive = true; return self; };
	public func Yeq(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.eq(anchor.lytT, val).isActive = true; return self; };
	public func Yeq(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.eq(anchor.lytB, val).isActive = true; return self; };

	public func Teq(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.eq(anchor.lytY, val).isActive = true; return self; };
	public func Teq(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.eq(anchor.lytT, val).isActive = true; return self; };
	public func Teq(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.eq(anchor.lytB, val).isActive = true; return self; };

	public func Beq(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.eq(anchor.lytY, val).isActive = true; return self; };
	public func Beq(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.eq(anchor.lytT, val).isActive = true; return self; };
	public func Beq(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.eq(anchor.lytB, val).isActive = true; return self; };

	public func Weq(W anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytW.eq(anchor.lytW, val).isActive = true; return self; };
	public func Weq(H anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytW.eq(anchor.lytH, val).isActive = true; return self; };

	public func Heq(W anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytH.eq(anchor.lytW, val).isActive = true; return self; };
	public func Heq(H anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytH.eq(anchor.lytH, val).isActive = true; return self; };

	public func Xeq(X anchor: UIView) -> Self { self.autolayout(true).lytX.eq(anchor.lytX).isActive = true; return self; };
	public func Xeq(L anchor: UIView) -> Self { self.autolayout(true).lytX.eq(anchor.lytL).isActive = true; return self; };
	public func Xeq(R anchor: UIView) -> Self { self.autolayout(true).lytX.eq(anchor.lytR).isActive = true; return self; };

	public func Leq(X anchor: UIView) -> Self { self.autolayout(true).lytL.eq(anchor.lytX).isActive = true; return self; };
	public func Leq(L anchor: UIView) -> Self { self.autolayout(true).lytL.eq(anchor.lytL).isActive = true; return self; };
	public func Leq(R anchor: UIView) -> Self { self.autolayout(true).lytL.eq(anchor.lytR).isActive = true; return self; };

	public func Req(X anchor: UIView) -> Self { self.autolayout(true).lytR.eq(anchor.lytX).isActive = true; return self; };
	public func Req(L anchor: UIView) -> Self { self.autolayout(true).lytR.eq(anchor.lytL).isActive = true; return self; };
	public func Req(R anchor: UIView) -> Self { self.autolayout(true).lytR.eq(anchor.lytR).isActive = true; return self; };

	public func Yeq(Y anchor: UIView) -> Self { self.autolayout(true).lytY.eq(anchor.lytY).isActive = true; return self; };
	public func Yeq(T anchor: UIView) -> Self { self.autolayout(true).lytY.eq(anchor.lytT).isActive = true; return self; };
	public func Yeq(B anchor: UIView) -> Self { self.autolayout(true).lytY.eq(anchor.lytB).isActive = true; return self; };

	public func Teq(Y anchor: UIView) -> Self { self.autolayout(true).lytT.eq(anchor.lytY).isActive = true; return self; };
	public func Teq(T anchor: UIView) -> Self { self.autolayout(true).lytT.eq(anchor.lytT).isActive = true; return self; };
	public func Teq(B anchor: UIView) -> Self { self.autolayout(true).lytT.eq(anchor.lytB).isActive = true; return self; };

	public func Beq(Y anchor: UIView) -> Self { self.autolayout(true).lytB.eq(anchor.lytY).isActive = true; return self; };
	public func Beq(T anchor: UIView) -> Self { self.autolayout(true).lytB.eq(anchor.lytT).isActive = true; return self; };
	public func Beq(B anchor: UIView) -> Self { self.autolayout(true).lytB.eq(anchor.lytB).isActive = true; return self; };

	public func Weq(W anchor: UIView) -> Self { self.autolayout(true).lytW.eq(anchor.lytW).isActive = true; return self; };
	public func Weq(H anchor: UIView) -> Self { self.autolayout(true).lytW.eq(anchor.lytH).isActive = true; return self; };

	public func Heq(W anchor: UIView) -> Self { self.autolayout(true).lytH.eq(anchor.lytW).isActive = true; return self; };
	public func Heq(H anchor: UIView) -> Self { self.autolayout(true).lytH.eq(anchor.lytH).isActive = true; return self; };

	public func Weq(_ val: CGFloat) -> Self 	{ self.autolayout(true).lytW.eq(val).isActive = true; return self; };
	public func Heq(_ val: CGFloat) -> Self 	{ self.autolayout(true).lytH.eq(val).isActive = true; return self; };

	// MARK: Greater Than
	public func Xge(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.ge(anchor.lytX, val).isActive = true; return self; };
	public func Xge(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.ge(anchor.lytL, val).isActive = true; return self; };
	public func Xge(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.ge(anchor.lytR, val).isActive = true; return self; };

	public func Lge(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.ge(anchor.lytX, val).isActive = true; return self; };
	public func Lge(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.ge(anchor.lytL, val).isActive = true; return self; };
	public func Lge(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.ge(anchor.lytR, val).isActive = true; return self; };

	public func Rge(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.ge(anchor.lytX, val).isActive = true; return self; };
	public func Rge(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.ge(anchor.lytL, val).isActive = true; return self; };
	public func Rge(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.ge(anchor.lytR, val).isActive = true; return self; };

	public func Yge(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.ge(anchor.lytY, val).isActive = true; return self; };
	public func Yge(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.ge(anchor.lytT, val).isActive = true; return self; };
	public func Yge(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.ge(anchor.lytB, val).isActive = true; return self; };

	public func Tge(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.ge(anchor.lytY, val).isActive = true; return self; };
	public func Tge(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.ge(anchor.lytT, val).isActive = true; return self; };
	public func Tge(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.ge(anchor.lytB, val).isActive = true; return self; };

	public func Bge(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.ge(anchor.lytY, val).isActive = true; return self; };
	public func Bge(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.ge(anchor.lytT, val).isActive = true; return self; };
	public func Bge(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.ge(anchor.lytB, val).isActive = true; return self; };

	public func Wge(W anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytW.ge(anchor.lytW, val).isActive = true; return self; };
	public func Wge(H anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytW.ge(anchor.lytH, val).isActive = true; return self; };

	public func Hge(W anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytH.ge(anchor.lytW, val).isActive = true; return self; };
	public func Hge(H anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytH.ge(anchor.lytH, val).isActive = true; return self; };

	public func Xge(X anchor: UIView) -> Self { self.autolayout(true).lytX.ge(anchor.lytX).isActive = true; return self; };
	public func Xge(L anchor: UIView) -> Self { self.autolayout(true).lytX.ge(anchor.lytL).isActive = true; return self; };
	public func Xge(R anchor: UIView) -> Self { self.autolayout(true).lytX.ge(anchor.lytR).isActive = true; return self; };

	public func Lge(X anchor: UIView) -> Self { self.autolayout(true).lytL.ge(anchor.lytX).isActive = true; return self; };
	public func Lge(L anchor: UIView) -> Self { self.autolayout(true).lytL.ge(anchor.lytL).isActive = true; return self; };
	public func Lge(R anchor: UIView) -> Self { self.autolayout(true).lytL.ge(anchor.lytR).isActive = true; return self; };

	public func Rge(X anchor: UIView) -> Self { self.autolayout(true).lytR.ge(anchor.lytX).isActive = true; return self; };
	public func Rge(L anchor: UIView) -> Self { self.autolayout(true).lytR.ge(anchor.lytL).isActive = true; return self; };
	public func Rge(R anchor: UIView) -> Self { self.autolayout(true).lytR.ge(anchor.lytR).isActive = true; return self; };

	public func Yge(Y anchor: UIView) -> Self { self.autolayout(true).lytY.ge(anchor.lytY).isActive = true; return self; };
	public func Yge(T anchor: UIView) -> Self { self.autolayout(true).lytY.ge(anchor.lytT).isActive = true; return self; };
	public func Yge(B anchor: UIView) -> Self { self.autolayout(true).lytY.ge(anchor.lytB).isActive = true; return self; };

	public func Tge(Y anchor: UIView) -> Self { self.autolayout(true).lytT.ge(anchor.lytY).isActive = true; return self; };
	public func Tge(T anchor: UIView) -> Self { self.autolayout(true).lytT.ge(anchor.lytT).isActive = true; return self; };
	public func Tge(B anchor: UIView) -> Self { self.autolayout(true).lytT.ge(anchor.lytB).isActive = true; return self; };

	public func Bge(Y anchor: UIView) -> Self { self.autolayout(true).lytB.ge(anchor.lytY).isActive = true; return self; };
	public func Bge(T anchor: UIView) -> Self { self.autolayout(true).lytB.ge(anchor.lytT).isActive = true; return self; };
	public func Bge(B anchor: UIView) -> Self { self.autolayout(true).lytB.ge(anchor.lytB).isActive = true; return self; };

	public func Wge(W anchor: UIView) -> Self { self.autolayout(true).lytW.ge(anchor.lytW).isActive = true; return self; };
	public func Wge(H anchor: UIView) -> Self { self.autolayout(true).lytW.ge(anchor.lytH).isActive = true; return self; };

	public func Hge(W anchor: UIView) -> Self { self.autolayout(true).lytH.ge(anchor.lytW).isActive = true; return self; };
	public func Hge(H anchor: UIView) -> Self { self.autolayout(true).lytH.ge(anchor.lytH).isActive = true; return self; };

	public func Wge(_ val: CGFloat) -> Self 	{ self.autolayout(true).lytW.ge(val).isActive = true; return self; };
	public func Hge(_ val: CGFloat) -> Self 	{ self.autolayout(true).lytH.ge(val).isActive = true; return self; };

	// MARK: Less Than
	public func Xle(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.le(anchor.lytX, val).isActive = true; return self; };
	public func Xle(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.le(anchor.lytL, val).isActive = true; return self; };
	public func Xle(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytX.le(anchor.lytR, val).isActive = true; return self; };

	public func Lle(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.le(anchor.lytX, val).isActive = true; return self; };
	public func Lle(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.le(anchor.lytL, val).isActive = true; return self; };
	public func Lle(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytL.le(anchor.lytR, val).isActive = true; return self; };

	public func Rle(X anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.le(anchor.lytX, val).isActive = true; return self; };
	public func Rle(L anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.le(anchor.lytL, val).isActive = true; return self; };
	public func Rle(R anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytR.le(anchor.lytR, val).isActive = true; return self; };

	public func Yle(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.le(anchor.lytY, val).isActive = true; return self; };
	public func Yle(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.le(anchor.lytT, val).isActive = true; return self; };
	public func Yle(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytY.le(anchor.lytB, val).isActive = true; return self; };

	public func Tle(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.le(anchor.lytY, val).isActive = true; return self; };
	public func Tle(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.le(anchor.lytT, val).isActive = true; return self; };
	public func Tle(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytT.le(anchor.lytB, val).isActive = true; return self; };

	public func Ble(Y anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.le(anchor.lytY, val).isActive = true; return self; };
	public func Ble(T anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.le(anchor.lytT, val).isActive = true; return self; };
	public func Ble(B anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytB.le(anchor.lytB, val).isActive = true; return self; };

	public func Wle(W anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytW.le(anchor.lytW, val).isActive = true; return self; };
	public func Wle(H anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytW.le(anchor.lytH, val).isActive = true; return self; };

	public func Hle(W anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytH.le(anchor.lytW, val).isActive = true; return self; };
	public func Hle(H anchor: UIView,_ val: CGFloat) -> Self { self.autolayout(true).lytH.le(anchor.lytH, val).isActive = true; return self; };

	public func Xle(X anchor: UIView) -> Self { self.autolayout(true).lytX.le(anchor.lytX).isActive = true; return self; };
	public func Xle(L anchor: UIView) -> Self { self.autolayout(true).lytX.le(anchor.lytL).isActive = true; return self; };
	public func Xle(R anchor: UIView) -> Self { self.autolayout(true).lytX.le(anchor.lytR).isActive = true; return self; };

	public func Lle(X anchor: UIView) -> Self { self.autolayout(true).lytL.le(anchor.lytX).isActive = true; return self; };
	public func Lle(L anchor: UIView) -> Self { self.autolayout(true).lytL.le(anchor.lytL).isActive = true; return self; };
	public func Lle(R anchor: UIView) -> Self { self.autolayout(true).lytL.le(anchor.lytR).isActive = true; return self; };

	public func Rle(X anchor: UIView) -> Self { self.autolayout(true).lytR.le(anchor.lytX).isActive = true; return self; };
	public func Rle(L anchor: UIView) -> Self { self.autolayout(true).lytR.le(anchor.lytL).isActive = true; return self; };
	public func Rle(R anchor: UIView) -> Self { self.autolayout(true).lytR.le(anchor.lytR).isActive = true; return self; };

	public func Yle(Y anchor: UIView) -> Self { self.autolayout(true).lytY.le(anchor.lytY).isActive = true; return self; };
	public func Yle(T anchor: UIView) -> Self { self.autolayout(true).lytY.le(anchor.lytT).isActive = true; return self; };
	public func Yle(B anchor: UIView) -> Self { self.autolayout(true).lytY.le(anchor.lytB).isActive = true; return self; };

	public func Tle(Y anchor: UIView) -> Self { self.autolayout(true).lytT.le(anchor.lytY).isActive = true; return self; };
	public func Tle(T anchor: UIView) -> Self { self.autolayout(true).lytT.le(anchor.lytT).isActive = true; return self; };
	public func Tle(B anchor: UIView) -> Self { self.autolayout(true).lytT.le(anchor.lytB).isActive = true; return self; };

	public func Ble(Y anchor: UIView) -> Self { self.autolayout(true).lytB.le(anchor.lytY).isActive = true; return self; };
	public func Ble(T anchor: UIView) -> Self { self.autolayout(true).lytB.le(anchor.lytT).isActive = true; return self; };
	public func Ble(B anchor: UIView) -> Self { self.autolayout(true).lytB.le(anchor.lytB).isActive = true; return self; };

	public func Wle(W anchor: UIView) -> Self { self.autolayout(true).lytW.le(anchor.lytW).isActive = true; return self; };
	public func Wle(H anchor: UIView) -> Self { self.autolayout(true).lytW.le(anchor.lytH).isActive = true; return self; };

	public func Hle(W anchor: UIView) -> Self { self.autolayout(true).lytH.le(anchor.lytW).isActive = true; return self; };
	public func Hle(H anchor: UIView) -> Self { self.autolayout(true).lytH.le(anchor.lytH).isActive = true; return self; };

	public func Wle(_ val: CGFloat) -> Self 	{ self.autolayout(true).lytW.le(val).isActive = true; return self; };
	public func Hle(_ val: CGFloat) -> Self 	{ self.autolayout(true).lytH.le(val).isActive = true; return self; };
};
