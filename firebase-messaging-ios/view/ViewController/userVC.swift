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

class userVC: UIViewController {

	var bodyStackV: UIStackView!
	var headImageV: UIImageView!
	var nameLbl		: UILabel!
	var emailLbl	: UILabel!

	var uid	: String?;
	var head: String?;
	var name: String?;
	
	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		ref = Database.database().reference();

		guard let uid = uid, let head = head, let name = name else { return; };

		let isFriend = {
			let filter = _friends.filter { e in
				guard let check = e["uid"] as? String else { return false; };
				return uid == check;
			};
			return filter.count == 1;
		}();

		bodyStackV = UIStackView(axis: .vert, align: .top);

		headImageV = UIImageView()
			.img(UIImage(name: head), mode: .scaleAspectFit)
			.bg(color: .white)
			.Weq(140)
			.Heq(140)
			.radius(70)
			.clip(view: true)

		nameLbl = UILabel()
			.text(name, color: _black, align: .center, row: 0, wrap: .byTruncatingTail)
			.font(weight: .medium, size: 24)
			.Weq(vw - 120)

		emailLbl = UILabel()
			.text(name, color: _black, align: .center, row: 0, wrap: .byTruncatingTail)
			.font(weight: .regular, size: 18)
			.Weq(vw - 120)
			.Heq(30)

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .light)
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
										headImageV
									]),
								UIView()
							]),
						UIStackView(axis: .vert, align: .top, gap: 30)
							.padding(T: 40)
							.padding(horz: 60)
							.child([
								nameLbl,
								emailLbl,
								UIStackView(axis: .horz, align: .left)
									.child([
										UIButton()
											.text(isFriend ? "移除好友" : "添加好友", color: isFriend ? .systemRed : .systemBlue)
											.font(weight: .medium, size: 18)
											.bg(color: _gray)
											.Weq(vw - 120)
											.Heq(35)
											.radius(5)
											.touch(down: self, isFriend ? #selector(removeFriend) : #selector(addFriend))
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

	@objc func addFriend() {
		guard let auth = Auth.auth().currentUser, let uid = uid, let head = head, let name = name else { return; };

		ref.child("friends/\(auth.uid)/\(uid)").setValue([
			"uid"	: uid,
			"head": head,
			"name": name
		]) { (error: Error?, ref: DatabaseReference) in
			if let _ = error { return; };
			self.dismiss(animated: true);
		};
	};

	@objc func removeFriend() {
		guard let auth = Auth.auth().currentUser, let uid = uid else { return; };

		ref.child("friends/\(auth.uid)/\(uid)").setValue(nil) { (error: Error?, ref: DatabaseReference) in
			if let _ = error { return; };
			self.dismiss(animated: true);
		};
	};
};
