/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class chatVC: UIViewController {

	var bodyStackV	: UIStackView!
	var userStackV	: UIStackView!
	var headBtn			: UIButton!
	var nameBtn			: UIButton!
	var chatTableV	: UITableView!
	var inputStackV	: UIStackView!
	var inputTextV	: UITextView!
	var sendBtn			: UIButton!

	var uid	: String?;
	var head: String?;
	var name: String?;
	
	var ref: DatabaseReference!

	var chats	: [[String:Any]] = [];
	var keyH	: CGFloat = 0;

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;
		let isArchieve = _archieve.filter { e in
			if let uid = uid, let check = e["uid"] as? String {
				return uid == check;
			};
			return false;
		}.count == 1;

		ref = Database.database().reference();

		bodyStackV = UIStackView(axis: .vert, align: .left, fill: .fill);

		userStackV = UIStackView(axis: .horz, align: .left, fill: .eqSpace)
			.padding(R: 10)
			.Weq(vw)
			.Heq(70)
			.layer([
				CALayer()._ { e in
					e.frame = CGRect(0, 69, vw, 1);
					e.backgroundColor = _gray.cgColor;
				}
			]);

		headBtn = UIButton()
			.touch(down: self, #selector(presentUserVC))
			.bg(color: _gray)
			.bg(image: UIImage(name: head ?? ""), mode: .scaleAspectFit)
			.radius(20)
			.clip(view: true)
			.Weq(40)
			.Heq(40);

		nameBtn = UIButton()
			.touch(down: self, #selector(presentUserVC))
			.text(name ?? "", color: _black)
			.font(weight: .medium, size: 20)
			.Heq(40);

		chatTableV = UITableView()
			.padding(B: 50)
			.proto(self, self)
			.cell(chatOwnerVCell.self, "chatOwnerVCell")
			.cell(chatGuestVCell.self, "chatGuestVCell")
			.bg(color: .clear)
			.separator(color: .clear)
			.rowH(auto: 50)
			.Weq(vw);

		inputStackV = UIStackView(axis: .horz, align: .left)
			.Weq(vw)
			.Heq(50 + safeB)
			.layer([
				CALayer()._ { e in
					e.frame = CGRect(-15, 0, vw + 15, 1);
					e.backgroundColor = _gray.cgColor;
				}
			]);

		inputTextV = UITextView()
			.proto(self)
			.padding(T: 6)
			.padding(horz: 15)
			.text("請輸入訊息內容", color: _gray, align: .left)
			.font(weight: .bold, size: 18)
			.bg(color: .clear)
			.Weq(vw - 40)
			.Heq(50);

		sendBtn = UIButton()
			.touch(down: self, #selector(sendMessage))
			.bg(image: UIImage(sys: "paperplane.fill"), color: _black, mode: .scaleAspectFit)
			.Weq(30)
			.Heq(50);

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				bodyStackV
					.child([
						userStackV
							.child([
								UIView()
									.Weq(30)
									.Heq(70),
								UIStackView(axis: .horz, align: .left)
									.padding(T: 15)
									.child([
										headBtn,
										nameBtn
									]),
								isArchieve ?
									UIView()
										.Weq(30)
										.Heq(70) :
									UIButton()
										.touch(down: self, #selector(addToArchieve))
										.bg(image: UIImage(sys: "archivebox"), color: _black, mode: .scaleAspectFit)
										.Weq(30)
										.Heq(70)
							]),
						chatTableV
					])
					.child(unsort: [
						inputStackV
							.child(unsort: [
								UIVisualEffectView(style: isDark ? .dark : .regular)
									.frame(0, 0, vw, 50 + safeB),
							])
							.child([
								inputTextV,
								sendBtn,
								UIView()
							])
					])
			]);

		_=bodyStackV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view, -safeB)
			.Req(R: view);

		_=inputStackV
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);

		getChat();

		let notify = NotificationCenter.default
		notify.addObserver(self, selector: #selector(showkeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
	};

	@objc func addToArchieve() {
		guard let auth = Auth.auth().currentUser, let uid = uid else { return; };
		ref.child("chatbox/\(auth.uid)/\(uid)").updateChildValues([
			"isArchieve": true
		]) { err, ref in
			if let err = err { print(err.localizedDescription); return; }
			self.dismiss(animated: true);
		};
	};

	@objc func presentUserVC() {
		let vc = userVC()._ { e in
			e.uid 	= uid;
			e.head 	= head;
			e.name 	= name;
		};
		self.present(vc, animated: true);
	};

	@objc func showkeyboard(aNotification: NSNotification) {

		let info: NSDictionary = aNotification.userInfo! as NSDictionary
		let value = info.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)
		let keyboard = (value as AnyObject).cgRectValue

		keyH = (keyboard?.size.height)!

		view.constraints.filter { e in
			return e.firstAnchor == inputStackV.bottomAnchor || e.secondAnchor == inputStackV.bottomAnchor
		}.forEach { e in
			view.removeConstraint(e)
		};
		inputStackV.constraints.filter { e in
			return e.firstAnchor == inputStackV.heightAnchor || e.secondAnchor == inputStackV.heightAnchor
		}.forEach { e in
			inputStackV.removeConstraint(e)
		};
		_=inputStackV
			.Beq(B: view, -keyH)
			.Heq(50);

		view.constraints.filter { e in
			return e.firstAnchor == bodyStackV.bottomAnchor || e.secondAnchor == bodyStackV.bottomAnchor
		}.forEach { e in
			view.removeConstraint(e)
		};
		_=bodyStackV
			.Beq(B: view, -keyH);
	};

	func getChat() {
		guard let auth = Auth.auth().currentUser, let uid = uid else { return; };

		ref.child("chats").child(auth.uid).child(uid).observe(.childAdded, with: { snap in
			let data = snap.value as? [String:Any] ?? [:];
			guard
				let content = data["content"] as? String,
				let from = data["from"] as? String,
				let upload = data["upload"] as? String
			else { return; };

			let isOwner = from == auth.uid;

			self.chats.append([
				"isOwner"	: isOwner,
				"uid"			: from,
				"message"	: content,
				"upload"	: upload
			]);
			self.chatTableV.insertRows(at: [IndexPath(item: self.chats.count-1, section: 0)], with: .automatic)
			self.chatTableV.setNeedsLayout();
			self.chatTableV.layoutIfNeeded();
			self.chatTableV.setContentOffset(CGPoint(0, self.chatTableV.contentSize.height -  self.chatTableV.bounds.height + 50), animated: false);
		});
	};

	@objc func sendMessage() {
		guard
			let authUid 	= Auth.auth().currentUser?.uid,
			let authHead 	= _auth["head"],
			let authName 	= _auth["name"],
			let uid 	= uid,
			let head 	= head,
			let name 	= name,
			let content = inputTextV.text
		else { return; };

		inputTextV.text = nil;
		
		let now = Date();
		let timestamp = "\(Int(now.timeIntervalSince1970))";
		ref.child("chats").child(authUid).child(uid).child(timestamp).setValue([
			"content"	: content,
			"from"		: authUid,
			"to"			: uid,
			"read"		: "1",
			"upload"	: timestamp
		]);
		ref.child("chats").child(uid).child(authUid).child(timestamp).setValue([
			"content"	: content,
			"from"		: authUid,
			"to"			: uid,
			"read"		: "0",
			"upload"	: timestamp
		]);
		ref.child("chatbox").child(authUid).child(uid).updateChildValues([
			"uid"			: uid,
			"head"		: head,
			"name"		: name,
			"last"		: content,
			"updated"	: timestamp,
			"read"		: "1",
			"isArchieve": false
		]);
		ref.child("chatbox").child(uid).child(authUid).updateChildValues([
			"uid"			: authUid,
			"head"		: authHead,
			"name"		: authName,
			"last"		: content,
			"updated"	: timestamp,
			"read"		: "0",
			"isArchieve": false
		]);
	};
};

extension chatVC: UITextViewDelegate {

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.textColor == _gray {
			textView.text = nil
			textView.textColor = _black
		}
	};

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.isEmpty {
			textView.text = "請輸入訊息內容"
			textView.textColor = _gray
		}
	};
};

extension chatVC: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return chats.count;
	};

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let data = chats[indexPath.row];
		guard let isOwner = data["isOwner"] as? Bool, let message = data["message"] as? String, let upload = data["upload"] as? String else { return UITableViewCell() };

		if (isOwner) {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatOwnerVCell") as? chatOwnerVCell else { return UITableViewCell(); };
			_=cell.messageLbl.text(message);
			_=cell.dateLbl.text(upload);
			return cell;
		}
		else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatGuestVCell") as? chatGuestVCell else { return UITableViewCell(); };
			_=cell.messageLbl.text(message);
			_=cell.dateLbl.text(upload);
			return cell;
		};
	};
};
