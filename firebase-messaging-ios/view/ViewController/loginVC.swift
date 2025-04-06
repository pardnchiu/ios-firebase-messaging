/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
//import ExSwift

var _black		: UIColor = UIColor(name: "Black") 		?? .clear;
var _gray			: UIColor = UIColor(name: "Gray") 		?? .clear;
var _darkGray	: UIColor = UIColor(name: "DarkGray") ?? .clear;
var _white		: UIColor = UIColor(name: "White") 		?? .clear;

class loginVC: UIViewController {

	var bodyStackV	: UIStackView!
	var emailTextF	: UITextField!
	var passwdTextF	: UITextField!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		_=view.bg(color: _white);
		
		bodyStackV = UIStackView(axis: .vert, align: .top);

		emailTextF = UITextField()
			.view(L: UIView(0, 0, 15, 0), mode: .always)
			.text(placeholder: "輸入信箱")
			.font(weight: .regular, size: 18)
			.bg(color: _gray)
			.radius(5)
			.Weq(vw - 120)
			.Heq(35);

		passwdTextF = UITextField()
			.view(L: UIView(0, 0, 15, 0), mode: .always)
			.text(placeholder: "輸入密碼")
			.text(secure: true)
			.font(weight: .regular, size: 18)
			.bg(color: _gray)
			.radius(5)
			.Weq(vw - 120)
			.Heq(35);

		_=view
			.child([
				bodyStackV
					.child([
						UIStackView(axis: .horz, align: .left, fill: .eqSpace)
							.padding(T: vh / 5)
							.Weq(vw)
							.child([
								UIView(),
								UIStackView(axis: .horz, align: .left, gap: 15)
									.child([
										UIImageView()
											.img(UIImage(name: "logo"), mode: .scaleAspectFit)
											.shadow(color: _black, alpha: 0.2, blur: 3, x: 0, y: 3)
											.Weq(80)
											.Heq(80),
										UIStackView(axis: .vert, align: .top, gap: 3)
											.padding(T: 5)
											.child([
												UILabel()
													.text("Firebase Messaging", color: _black, align: .left, row: 1, wrap: .byClipping)
													.font(weight: .regular, size: 16),
												UILabel()
													.text("Firebase 即時訊息", color: _black, align: .left, row: 1, wrap: .byClipping)
													.font(weight: .bold, size: 22),
												UILabel()
													.text("iOS 版本", color: _black, align: .left, row: 1, wrap: .byClipping)
													.font(weight: .regular, size: 18)
											])
									]),
								UIView()
							]),
						UIStackView(axis: .vert, align: .top, gap: 30)
							.padding(T: 40)
							.padding(horz: 60)
							.child([
								emailTextF,
								passwdTextF,
								UIStackView(axis: .horz, align: .left, gap: 30)
									.child([
										UIButton()
											.text("登入", color: isDark ? _black : .systemBlue)
											.font(weight: .medium, size: 20)
											.touch(down: self, #selector(authLogin))
											.bg(color: _gray)
											.radius(5)
											.Weq((vw - 150) / 2)
											.Heq(35),
										UIButton()
											.text("註冊", color: isDark ? _black : .systemBlue)
											.font(weight: .medium, size: 20)
											.touch(down: self, #selector(presentSignupVC))
											.bg(color: _gray)
											.radius(5)
											.Weq((vw - 150) / 2)
											.Heq(35)
									])
							]),
						UIView()
					])
			]);

		_=bodyStackV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);
	};

	override func viewDidAppear(_ animated: Bool) {
		guard let _ = Auth.auth().currentUser else { return; };
		self.presentLoginVC();
	};

	@objc func authLogin() {
		guard
			let email = emailTextF.text,
			let password = passwdTextF.text
		else { return; };

		Auth.auth().signIn(withEmail: email, password: password) { _, err in
			if let err = err { print(err.localizedDescription); return; };
			self.presentLoginVC();
		};
	};

	@objc func presentLoginVC() {
		let vc = homeVC();
		vc.modalPresentationStyle = .overFullScreen;
		self.present(vc, animated: true);
	};

	@objc func presentSignupVC() {
		let vc = signupVC();
		present(vc, animated: true);
	};
};
