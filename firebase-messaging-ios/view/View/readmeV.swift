/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

class readmeV: UIView {

	var root: homeVC!
	var headerLbl	: UILabel!
	var bodyStackV: UIStackView!

	convenience init(root: homeVC) {
		self.init(0, 0, vw, vh);

		self.root = root;

		headerLbl = UILabel(15, 0, vw - 40, 100)
			.attr(txt: "關於我", clr: _black, align: .left)
			.attr(minH: 90)
			.font(weight: .medium, size: 40)
			.bg(color: _white);

		bodyStackV = UIStackView(axis: .vert, align: .top, fill: .eqSpace)
			.padding(T: 130)
			.padding(horz: 15);

		_=child([
			bodyStackV
				.child([
					UIStackView(axis: .vert, align: .top, gap: 10)
						.child([
							UILabel()
								.text("Firebase Messager (iOS)", color: _black, align: .left, row: 0, wrap: .byTruncatingTail)
								.font(weight: .bold, size: 24),
							UILabel()
								.text("・Swift", color: _black, align: .left, row: 0, wrap: .byTruncatingTail)
								.font(weight: .regular, size: 20),
							UILabel()
								.text("・Pardn Chiu 邱敬幃", color: _black, align: .left, row: 0, wrap: .byTruncatingTail)
								.font(weight: .regular, size: 20),
							UIButton()
								.padding(0)
								.text("・joball.tw/@pardnltd", color: .systemBlue)
								.font(weight: .regular, size: 20)
								.touch(down: self, #selector(openJOBALL)),
							UIButton()
								.padding(0)
								.text("・linkedin.com/in/pardnchiu", color: .systemBlue)
								.font(weight: .regular, size: 20)
								.touch(down: self, #selector(openLinkedin)),
							UIButton()
								.padding(0)
								.text("・lin.ee/Gtcb5kc", color: .systemBlue)
								.font(weight: .regular, size: 20)
								.touch(down: self, #selector(openLine))
						]),
					UIView()
				]),
			headerLbl
		]);

		_=bodyStackV
			.Teq(T: self)
			.Leq(L: self)
			.Beq(B: self)
			.Req(R: self);
	};

	@objc func openJOBALL() {
		let vc = webVC();
		vc.url = "https://joball.tw/@pardnltd";
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func openLinkedin() {
		let vc = webVC();
		vc.url = "https://www.linkedin.com/in/pardnchiu";
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func openLine() {
		let vc = webVC();
		vc.url = "https://lin.ee/Gtcb5kc";
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};
};
