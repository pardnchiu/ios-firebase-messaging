/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class friendsV: UIView {
	
	var headerLbl	: UILabel!
	var bodyTableV: UITableView!
	
	convenience init(_ delegate: UITableViewDelegate,_ datasoruce: UITableViewDataSource) {
		self.init(0, 0, vw, vh);
		
		headerLbl = UILabel(15, 0, vw - 40, 100)
			.attr(txt: "好友", clr: _black, align: .left)
			.attr(minH: 90)
			.font(weight: .medium, size: 40)
			.bg(color: _white);
		
		bodyTableV = UITableView()
			.proto(delegate, datasoruce)
			.cell(friendsTableVCell.self, "friendsTableVCell")
			.padding(T: 130)
			.bg(color: .clear)
			.separator(color: .clear)
			.indicator(val: false);
		
		_=child([
			bodyTableV,
			headerLbl
		]);
		
		_=bodyTableV
			.Teq(T: self)
			.Leq(L: self)
			.Beq(B: self)
			.Req(R: self);
	};
};
