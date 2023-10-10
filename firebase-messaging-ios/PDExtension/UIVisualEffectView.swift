/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UIVisualEffectView {

	@objc convenience public init(style: UIBlurEffect.Style) { self.init(effect: UIBlurEffect(style: style)); };
};

extension UIVisualEffectView {

	public override func child(_ views: [UIView]) -> Self { views.forEach { e in self.contentView.addSubview(e); }; return self; };
};
