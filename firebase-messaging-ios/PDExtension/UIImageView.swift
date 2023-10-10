/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UIImageView {

	public func img(_ img: UIImage?, mode: UIView.ContentMode) -> Self { self.image = img ?? _image; self.contentMode = mode; return self; };
};


