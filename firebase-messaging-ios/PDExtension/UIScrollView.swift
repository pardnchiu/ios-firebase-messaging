/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UIScrollView {

	@objc public func proto(_ del: UIScrollViewDelegate) -> Self { delegate = del; return self; };

	@objc public func indicator(val: Bool) -> Self { showsVerticalScrollIndicator = val; showsHorizontalScrollIndicator = val; return self; };
};
