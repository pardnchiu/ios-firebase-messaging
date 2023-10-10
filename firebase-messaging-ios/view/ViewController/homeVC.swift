/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import UIKit;
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

var _auth			: [String:String] = [:];
var _friends	: [[String:Any]] 	= [];
var _chats		: [[String:Any]] 	= [];
var _archieve	: [[String:Any]] 	= [];

class homeVC: UIViewController {

	var offset: CGPoint = CGPoint(0, 0);
	
	var bodyScrollV	: UIScrollView!
	var bodyStackV	: UIStackView!
	var accountV		: accountV!
	var friendsV		: friendsV!
	var chatsV			: chatsV!
	var readmeV			: readmeV!
	var bottomV			: bottomV!

	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad();

		ref = Database.database().reference();

		bodyScrollV = UIScrollView()
			.proto(self)
			.bg(color: _white)
			.indicator(val: false)
			._ { e in
				e.bounces = false;
				e.contentSize = CGSize((vw - 40) * 3 + vw, vh);
				e.contentOffset = CGPoint(vw - 40, 0)
			};

		bodyStackV = UIStackView(axis: .horz, align: .left);

		accountV = firebase_messaging_ios.accountV(rootVC: self)
			.Weq(vw - 40);

		friendsV = firebase_messaging_ios.friendsV(self, self)
			.Weq(vw - 40);

		chatsV = firebase_messaging_ios.chatsV(self, self)
			.Weq(vw - 40);

		readmeV = firebase_messaging_ios.readmeV(root: self)
			.Weq(vw);

		bottomV = firebase_messaging_ios.bottomV(root: self, show: .friends)
			.Heq(60);

		_=view
			.child([
				bodyScrollV
					.child([
						bodyStackV
							.child([
								accountV,
								friendsV,
								chatsV,
								readmeV
							])
					]),
				bottomV
			]);

		_=bodyScrollV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);
		
		_=bodyStackV
			.Teq(T: bodyScrollV, safeT)
			.Leq(L: bodyScrollV)
			.Beq(T: bottomV)
			.Req(R: bodyScrollV);

		_=bottomV
			.Leq(L: view)
			.Beq(B: view, -safeB)
			.Req(R: view);

		_=accountV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		_=friendsV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		_=chatsV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		_=readmeV
			.Teq(T: bodyStackV)
			.Beq(B: bodyStackV);

		getAuth();
		getFriends();
		getChats();
	};

	func getAuth() {
		guard let auth = Auth.auth().currentUser else { return; };

		ref.child("users/\(auth.uid)").observeSingleEvent(of: .value, with: { snap in
			guard
				let data = snap.value as? [String:Any],
				let head = data["head"] as? String,
				let name = data["name"] as? String,
				let email = auth.email
			else { return; };

			_auth = [
				"uid"		: auth.uid,
				"head"	: head,
				"name"	: name,
				"email"	: email,
			];

			_=self.accountV._ { e in
				_=e.headBtn.img(UIImage(name: head));
				_=e.nameTextF.text(name);
				_=e.emailTextF.text(email);
			};
		});
	};

	func getFriends() {
		guard let auth = Auth.auth().currentUser else { return; };

		ref.child("friends/\(auth.uid)").observe(.childAdded, with: { snap in
			guard
				let data = snap.value as? [String:Any],
				let head = data["head"] as? String,
				let name = data["name"] as? String
			else { return; };

			_friends.append([
				"uid"	: snap.key,
				"head": head,
				"name": name
			]);

			self.friendsV.bodyTableV.reloadData();
		});

		ref.child("friends/\(auth.uid)").observe(.childRemoved, with: { snap in
			guard let data = snap.value as? [String:Any] else { return; };

			let index = _friends.firstIndex { chat in
				let A = chat["uid"] as? String ?? "";
				let B = data["uid"] as? String ?? "";
				return A == B;
			};
			_friends.remove(at: index ?? -1);

			self.friendsV.bodyTableV.reloadData();
		});
	};

	func getChats() {
		guard let auth = Auth.auth().currentUser else { return; };

		ref.child("chatbox/\(auth.uid)").observe(.childAdded, with: { snap in
			guard
				let data = snap.value as? [String:Any],
				let isArchieve = data["isArchieve"] as? Bool
			else { return; };

			if (isArchieve) {
				_archieve.append(data);
				_archieve.sort { a, b -> Bool in
					guard
						let A = a["updated"] as? String,
						let B = b["updated"] as? String
					else { return false; };

					return A.compare(B) == .orderedDescending;
				};
			}
			else {
				_chats.append(data);
				_chats.sort { a, b -> Bool in
					guard
						let A = a["updated"] as? String,
						let B = b["updated"] as? String
					else { return false; };

					return A.compare(B) == .orderedDescending;
				};
			};
			self.chatsV.bodyTableV.reloadData();
		});

		ref.child("chatbox/\(auth.uid)").observe(.childChanged, with: { snap in
			guard
				let data = snap.value as? [String:Any],
				let isArchieve = data["isArchieve"] as? Bool
			else { return; };

			let chatIndex = _chats.firstIndex { chat in
				guard
					let A = chat["uid"] as? String,
					let B = data["uid"] as? String
				else { return false; };

				return A == B;
			};

			if let index = chatIndex { _chats.remove(at: index); };

			let archieveIndex = _archieve.firstIndex { chat in
				guard
					let A = chat["uid"] as? String,
					let B = data["uid"] as? String
				else { return false; };

				return A == B;
			};

			if let index = archieveIndex { _archieve.remove(at: index); };

			if (isArchieve) {
				_archieve.append(data);
				_archieve.sort { a, b -> Bool in
					guard
						let A = a["updated"] as? String,
						let B = b["updated"] as? String
					else { return false; };

					return A.compare(B) == .orderedDescending;
				};
			}
			else {
				_chats.append(data);
				_chats.sort { a, b -> Bool in
					guard
						let A = a["updated"] as? String,
						let B = b["updated"] as? String
					else { return false; };

					return A.compare(B) == .orderedDescending;
				};
			};
			self.chatsV.bodyTableV.reloadData();
		});
	};
};

extension homeVC: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableView {
			case friendsV.bodyTableV: return _friends.count;
			case chatsV.bodyTableV: return _chats.count;
			default: return 0;
		};
	};

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch tableView {
			case friendsV.bodyTableV: return 90;
			case chatsV.bodyTableV: return 115;
			default: return 0;
		};
	};

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch tableView {
			case friendsV.bodyTableV:
				let data: [String:Any] = _friends[indexPath.row];

				guard
					let cell = tableView.dequeueReusableCell(withIdentifier: "friendsTableVCell") as? friendsTableVCell,
					let head = data["head"] as? String,
					let name = data["name"] as? String
				else { return UITableViewCell(); };

				_=cell.headImageV.img(UIImage(name: head), mode: .scaleAspectFill);
				_=cell.nameLbl.text(name);

				return cell;

			case chatsV.bodyTableV:
				let data: [String:Any] = _chats[indexPath.row];

				guard
					let cell = tableView.dequeueReusableCell(withIdentifier: "chatsTableVCell") as? chatsTableVCell,
					let head = data["head"] as? String,
					let name = data["name"] as? String,
					let last = data["last"] as? String
				else { return UITableViewCell(); };

				_=cell.headImageV.img(UIImage(name: head), mode: .scaleAspectFill);
				_=cell.nameLbl.text(name);
				_=cell.dateLbl.text("1分鐘前");
				_=cell.contentLbl.text(last);

				return cell;

			default: return UITableViewCell();
		};
	};

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch tableView {
			case friendsV.bodyTableV:
				let user = _friends[indexPath.row];
				guard
					let uid = user["uid"] as? String,
					let head = user["head"] as? String,
					let name = user["name"] as? String
				else { return; };

				let vc = chatVC()._ { e in
					e.uid 	= uid;
					e.head 	= head;
					e.name 	= name;
				};

				self.present(vc, animated: true);

			case chatsV.bodyTableV:
				let chat = _chats[indexPath.row];
				guard
					let uid 	= chat["uid"] as? String,
					let head 	= chat["head"] as? String,
					let name 	= chat["name"] as? String
				else { return; };

				let vc = chatVC()._ { e in
					e.uid 	= uid;
					e.head 	= head;
					e.name 	= name;
				};

				self.present(vc, animated: true);

			default: break;
		};
	};
};

extension homeVC: UIScrollViewDelegate {

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		offset = scrollView.contentOffset;
	};

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		offset = scrollView.contentOffset;
	};

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if scrollView == self.bodyScrollV {
			var offsetX: CGFloat = scrollView.contentOffset.x;
			switch true {
				case offsetX >= (vw - 40) * 2.5: offsetX = (vw - 40) * 3; bottomV.change(to: .about); break;
				case offsetX >= (vw - 40) * 1.5: offsetX = (vw - 40) * 2; bottomV.change(to: .chats); break;
				case offsetX >= (vw - 40) * 0.5: offsetX = vw - 40; bottomV.change(to: .friends); break;
				default: offsetX = 0; bottomV.change(to: .account); break;
			}
			DispatchQueue.main.async {
				scrollView.setContentOffset(CGPoint(offsetX, 0), animated: true)
			};
		};
	};
};
