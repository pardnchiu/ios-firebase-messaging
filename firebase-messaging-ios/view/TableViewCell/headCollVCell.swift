/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class headCollVCell: UICollectionViewCell {

	var headBtn: UIButton!

	override init(frame: CGRect) {
		super.init(frame: CGRect(0, 0, 0, 0));

		headBtn = UIButton();

		_=contentView.child([
			headBtn
				.Weq(vw / 3)
				.Heq(vw / 3)
		]);
	};

	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder);
	};
};

