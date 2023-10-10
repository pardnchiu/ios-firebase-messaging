/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class bottomV: UIView {

	var root				: homeVC!
	var bodyStackV	: UIStackView!
	var qrcodeBtn		: UIButton!
	var modeBtn			: UIButton!
	var logoutBtn		: UIButton!
	var scannerBtn	: UIButton!
	var archieveBtn	: UIButton!
	var licenseBtn	: UIButton!

	enum __target {
		case account;
		case friends;
		case chats;
		case about;
	};

	convenience init(root: homeVC, show: __target) {
		self.init();

		_=bg(color: _white);

		self.root = root;

		qrcodeBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "qrcode"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(showQrcodeViewController));

		modeBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "moon.circle"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(changeMode));

		logoutBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "rectangle.portrait.and.arrow.right"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(logout));

		scannerBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "qrcode.viewfinder"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(openScannerVC));

		archieveBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "archivebox"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(openArchieveVC));

		licenseBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "l.circle"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40)
			.touch(down: self, #selector(openLicense));

		bodyStackV = UIStackView(axis: .horz, align: .center, fill: .eqSpace, gap: 30)

		_=child([
				bodyStackV
					.child([
						scannerBtn
					])
					.Heq(60)
			])
			.layer([
				CALayer()._ { e in
					e.frame = CGRect(0, 0, vw, 1);
					e.backgroundColor = _gray.cgColor;
				}
			])
			.clip(view: true)

		_=bodyStackV
			.Xeq(X: self)
			.Yeq(Y: self);
	};

	func change(to: __target) {
		bodyStackV.subviews.forEach { e in
			e.removeFromSuperview();
		};
		switch to {
			case .account:
				_=bodyStackV
					.child([
						qrcodeBtn,
						modeBtn,
						logoutBtn
					]);
				break;
			case .friends:
				_=bodyStackV
					.child([
						scannerBtn
					]);
				break;
			case .chats:
				_=bodyStackV
					.child([
						archieveBtn
					]);
				break;
			case .about:
				_=bodyStackV
					.child([
						licenseBtn,
					]);
				break;
		};
	};

	@objc func showQrcodeViewController() {
		let vc = qrcodeVC();
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func openScannerVC() {
		let vc = scannerVC();
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func openArchieveVC() {
		let vc = archieveVC();
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func openLicense() {
		let vc = webVC();
		vc.url = "https://github.com/pardnchiu/firebase-messager-ios/blob/main/LICENSE";
		guard let _ = root.presentedViewController else {
			root.present(vc, animated: true);
			return;
		};
	};

	@objc func changeMode() {
		let isDark = window?.traitCollection.userInterfaceStyle == .dark;
		window?.overrideUserInterfaceStyle = isDark ? .light : .dark
	};

	@objc func logout() {
		let firebaseAuth = Auth.auth();
		do {
			try firebaseAuth.signOut();
		} catch let signOutError as NSError {
			print("Error signing out: %@", signOutError)
		};
		_auth 		= [:];
		_friends 	= [];
		_chats 		= [];
		root.dismiss(animated: true);
	};
};
