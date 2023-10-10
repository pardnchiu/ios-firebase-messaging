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

class signupVC: UIViewController {

	var bodyStackV	: UIStackView!
	var headBtn			: UIButton!
	var nameTextF		: UITextField!
	var emailTextF	: UITextField!
	var passwdTextF	: UITextField!
	var checkTextF	: UITextField!

	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		ref = Database.database().reference();

		bodyStackV = UIStackView(axis: .vert, align: .top);

		headBtn = UIButton()
			.touch(down: self, #selector(presentHeadSelectVC))
			.text("選擇頭像", color: _black)
			.img(UIImage(sys: "person.fill"), align: .left, gap: 5)
			.bg(color: _gray)
			.radius(70)
			.clip(view: true)
			.Weq(140)
			.Heq(140)

		nameTextF = UITextField()
			.view(L: UIView(0, 0, 15, 0), mode: .always)
			.text(placeholder: "輸入名稱")
			.font(weight: .regular, size: 18)
			.bg(color: _gray)
			.radius(5)
			.Weq(vw - 120)
			.Heq(35);

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

		checkTextF = UITextField()
			.view(L: UIView(0, 0, 15, 0), mode: .always)
			.text(placeholder: "確認密碼")
			.text(secure: true)
			.font(weight: .regular, size: 18)
			.bg(color: _gray)
			.radius(5)
			.Weq(vw - 120)
			.Heq(35);

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				bodyStackV
					.child([
						UIStackView(axis: .horz, align: .left, fill: .eqSpace)
							.padding(T: 60)
							.Weq(vw)
							.child([
								UIView(),
								UIStackView(axis: .horz, align: .left, gap: 15)
									.child([
										headBtn
									]),
								UIView()
							]),
						UIStackView(axis: .vert, align: .top, gap: 30)
							.padding(T: 40)
							.padding(horz: 60)
							.child([
								nameTextF,
								emailTextF,
								passwdTextF,
								checkTextF,
								UIStackView(axis: .horz, align: .left)
									.child([
										UIButton()
											.touch(down: self, #selector(singup))
											.text("確定註冊", color: isDark ? _black : .systemBlue)
											.font(weight: .medium, size: 18)
											.bg(color: _gray)
											.radius(5)
											.Weq(vw - 120)
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

	@objc func presentHeadSelectVC() {
		let vc = headSelectVC();
		present(vc, animated: true);
	};

	@objc func singup() {
		guard
			let name 		= nameTextF.text,
			let email 	= emailTextF.text,
			let passwd 	= passwdTextF.text,
			let check		= checkTextF.text,
			let head 		= headBtn.configuration?.background.image?.imageAsset?.value(forKey: "assetName")
		else { return; };

		if (check != passwd) { return; };

		let now = Date();
		let timestamp = "\(now.timeIntervalSince1970)";

		Auth.auth().createUser(withEmail: email, password: passwd) { r, err in
			if let err = err { print(err.localizedDescription); return; };

			guard let auth = r?.user else { return; };

			self.ref.child("users").child(auth.uid).setValue([
				"head": head,
				"name": name,
				"signup": timestamp
			]) { err, ref in
				if let err = err { print(err.localizedDescription); return; };
				self.dismiss(animated: true);
			};
		};
	};
};
