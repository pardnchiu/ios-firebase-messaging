/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class chatsTableVCell: UITableViewCell {
	
	var bodyStackV: UIStackView!
	var headImageV: UIImageView!
	var nameLbl		: UILabel!
	var dateLbl		: UILabel!
	var contentLbl: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier);
		
		self.selectedBackgroundView = UIView()
		
		_=bg(color: .clear);
		
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
			.Heq(30);
		
		dateLbl = UILabel()
			.text("", color: _darkGray, align: .left, row: 1, wrap: .byTruncatingTail)
			.font(weight: .regular, size: 16)
			.Heq(25);
		
		contentLbl = UILabel()
			.text("", color: _black, align: .left, row: 1, wrap: .byTruncatingTail)
			.font(weight: .regular, size: 18)
			.Heq(30);
		
		_=child([
			bodyStackV
				.child([
					headImageV,
					UIStackView(axis: .vert, align: .top)
						.child([
							nameLbl,
							dateLbl,
							contentLbl
						])
				])
		]);
		
		_=bodyStackV
			.Teq(T: self)
			.Leq(L: self)
			.Beq(B: self)
			.Req(R: self);
	};
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder:aDecoder)
	};
};
