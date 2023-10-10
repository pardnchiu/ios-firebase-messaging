/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class accountV: UIScrollView {
	
	var rootVC			: homeVC!
	var headerLbl		: UILabel!
	var bodyStackV	: UIStackView!
	var headBtn			: UIButton!
	var nameTextF		: UITextField!
	var emailTextF	: UITextField!
	var passwdTextF	: UITextField!

	var ref: DatabaseReference!
	
	convenience init(rootVC: homeVC) {
		self.init();
		
		self.rootVC = rootVC;

		ref = Database.database().reference();
		
		headerLbl = UILabel(15, 0, vw - 40, 100)
			.attr(txt: "帳戶", clr: _black, align: .left)
			.attr(minH: 90)
			.font(weight: .medium, size: 40)
			.bg(color: _white);
		
		bodyStackV = UIStackView(axis: .vert, align: .left, gap: 30)
			.padding(T: 130)
			.padding(L: 15);
		
		headBtn = UIButton()
			.touch(down: self, #selector(presentHeadSelectVC))
			.bg(image: nil, mode: .scaleAspectFill)
			.bg(color: _gray)
			.radius(80)
			.clip(view: true)
			.Weq(160)
			.Heq(160);
		nameTextF = UITextField()
			.view(L: UIView(0, 0, 15, 30), mode: .always)
			.view(R: UIButton(0, 0, 30, 30).img(UIImage(sys: "arrow.triangle.2.circlepath.circle.fill")).text(color: _black).touch(down: self, #selector(updateName)), mode: .whileEditing)
			.bg(color: _gray)
			.radius(5)
			.Weq(vw - 70)
			.Heq(30);
		
		emailTextF = UITextField()
			.view(L:  UIView(0, 0, 15, 30), mode: .always)
			.view(R: UIButton(0, 0, 30, 30).img(UIImage(sys: "arrow.triangle.2.circlepath.circle.fill")).text(color: _black).touch(down: self, #selector(updateEmail)), mode: .whileEditing)
			.bg(color: _gray)
			.radius(5)
			.Weq(vw - 70)
			.Heq(30);
		
		passwdTextF = UITextField()
			.view(L:  UIView(0, 0, 15, 30), mode: .always)
			.view(R: UIButton(0, 0, 30, 30).img(UIImage(sys: "arrow.triangle.2.circlepath.circle.fill")).text(color: _black).touch(down: self, #selector(updatePasswd)), mode: .whileEditing)
			.bg(color: _gray)
			.Weq(vw - 70)
			.radius(5)
			.Heq(30);
		
		_=child([
			bodyStackV
				.child([
					headBtn,
					UIStackView(axis: .vert, align: .left, gap: 10)
						.child([
							UILabel()
								.text("名稱", color: _black, align: .left, row: 1, wrap: .byClipping)
								.font(weight: .medium, size: 18)
								.Weq(vw - 70)
								.Heq(20),
							nameTextF
						]),
					UIStackView(axis: .vert, align: .left, gap: 10)
						.child([
							UILabel()
								.text("信箱", color: _black, align: .left, row: 1, wrap: .byClipping)
								.font(weight: .medium, size: 18),
							emailTextF
						]),
					UIStackView(axis: .vert, align: .left, gap: 10)
						.child([
							UILabel()
								.text("密碼", color: _black, align: .left, row: 1, wrap: .byClipping)
								.font(weight: .medium, size: 18),
							passwdTextF
						])
				]),
			headerLbl
		])
		
		_=bodyStackV
			.Teq(T: self)
			.Leq(L: self)
			.Beq(B: self)
			.Req(R: self)
	};

	@objc func updateName() {
		guard
			let auth = Auth.auth().currentUser,
			let name = nameTextF.text
		else { return; };

		ref.child("users/\(auth.uid)").updateChildValues([
			"name": name
		], withCompletionBlock: { err, ref in
			if let err = err { return print(err.localizedDescription); };
			self.alert("成功更改名稱");
		});
	};

	@objc func updateEmail() {
		guard
			let _ = Auth.auth().currentUser,
			let email = emailTextF.text
		else { return; };
		Auth.auth().currentUser?.updateEmail(to: email) { err in
			if let err = err { return print(err.localizedDescription); };
			self.alert("成功更改信箱");
		};
	};

	@objc func updatePasswd() {
		guard
			let _ = Auth.auth().currentUser,
			let password = passwdTextF.text
		else { return; };
		Auth.auth().currentUser?.updatePassword(to: password) { err in
			if let err = err { return print(err.localizedDescription); };
			self.alert("成功更改密碼");
		};
	};
	
	@objc func presentHeadSelectVC() {
		let vc = headSelectVC();
		guard let _ = rootVC.presentedViewController else {
			rootVC.present(vc, animated: true);
			return;
		};
	};

	func alert(_ message: String) {
		let alert = UIAlertController(title: "通知", message: message, preferredStyle: .alert);
		let cancel = UIAlertAction(title: "確定", style: .cancel, handler: nil)
		alert.addAction(cancel)
		guard let _ = rootVC.presentedViewController else {
			rootVC.present(alert, animated: true);
			return;
		};
	};
};
