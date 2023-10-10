/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class chatOwnerVCell: UITableViewCell {

	var bodyStackV: UIStackView!
	var messageLbl: UILabel!
	var dateLbl   : UILabel!

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier);

		_=bg(color: .clear);

		selectedBackgroundView = UIView();

		bodyStackV = UIStackView(axis: .vert, align: .right)
			.padding(vert: 15, horz: 10)
			.bg(color: .systemBlue)
			.radius(10);

		messageLbl = UILabel()
			.text("", color: .white, align: .right, row: 0, wrap: .byClipping)
			.font(italic: 16);

		dateLbl = UILabel()
			.text("", color: _gray, align: .right, row: 0, wrap: .byClipping)
			.font(italic: 14)
			.alpha(0);

		_=contentView
			.child([
				bodyStackV
					.child([
						messageLbl
					]),
				dateLbl
			]);

		_=bodyStackV
			.Teq(T: contentView, 10)
			.Lge(L: contentView, 110)
			.Beq(B: contentView, -10)
			.Req(R: contentView, -15);

		_=dateLbl
			.Beq(B: bodyStackV, -10)
			.Req(L: bodyStackV, -10);
	};

	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)
	};
};

