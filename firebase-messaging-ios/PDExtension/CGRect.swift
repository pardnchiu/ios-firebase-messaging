/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation;
import UIKit;

public extension CGRect {

	init(_ point: CGPoint,_ size: CGSize) { self.init(origin: point, size: size); };
	init(_ x: CGFloat,_ y: CGFloat,_ width: CGFloat,_ height: CGFloat) { self.init(x: x, y: y, width: width, height: height); };
};
