//
//  CAGradientLayer.swift
//  Maoneybook
//
//  Created by Pardn on 2023/5/3.
//

import Foundation
import UIKit

public extension CAGradientLayer {

	func frame(_ x: CGFloat,_ y: CGFloat,_ w: CGFloat,_ h: CGFloat) -> CAGradientLayer { self.frame = CGRect(x: x, y: y, width: w, height: h); return self; };
	func bg(clr: UIColor) -> CAGradientLayer { self.backgroundColor = clr.cgColor; return self; };
	func point(start x: CGFloat,_ y: CGFloat) -> CAGradientLayer { self.startPoint = CGPoint(x: x, y: y); return self; };
	func point(end 	 x: CGFloat,_ y: CGFloat) -> CAGradientLayer { self.endPoint = CGPoint(x: x, y: y); return self; };
}
