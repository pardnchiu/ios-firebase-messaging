/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class friendsTableVCell: UITableViewCell {
	
	var bodyStackV: UIStackView!
	var headImageV: UIImageView!
	var nameLbl		: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier);
		
		_=bg(color: .clear);
		selectedBackgroundView = UIView()
		
		bodyStackV = UIStackView(axis: .horz, align: .left, gap: 20)
			.padding(horz: 15)
			.padding(B: 30);
		
		headImageV = UIImageView()
			.bg(color: _gray)
			.Weq(60)
			.Heq(60)
			.radius(30)
			.clip(view: true);
		
		nameLbl = UILabel()
			.text("", color: _black, align: .left, row: 1, wrap: .byTruncatingTail)
			.font(weight: .medium, size: 22)
			.Heq(60)
		
		_=child([
			bodyStackV
				.child([
					headImageV,
					nameLbl
				])
		]);
		
		_=bodyStackV
			.Teq(T: self)
			.Leq(L: self)
			.Beq(B: self)
			.Req(R: self)
	};
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)
	};
};
