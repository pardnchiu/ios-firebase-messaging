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

class archieveVC: UIViewController {

	var listTableV: UITableView!

	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		ref = Database.database().reference();

		_=view.bg(color: .clear);

		listTableV = UITableView()
			.padding(T: 20)
			.proto(self, self)
			.cell(archieveTableVCell.self, "archieveTableVCell")
			.bg(color: .clear)
			.separator(color: .clear)
			.rowH(auto: 50);

		_=view.child([
			UIVisualEffectView(style: isDark ? .dark : .extraLight)
				.frame(0, 0, vw, vh),
			listTableV
		]);

		_=listTableV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);
	};
};

extension archieveVC: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return _archieve.count;
	};

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let data: [String:Any] = _archieve[indexPath.row];

		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: "archieveTableVCell") as? archieveTableVCell,
			let head = data["head"] as? String,
			let name = data["name"] as? String
		else { return UITableViewCell(); };

		_=cell.headImageV.img(UIImage(name: head), mode: .scaleAspectFill);
		_=cell.nameLbl.text(name);

		return cell;
	};

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		let data: [String:Any] = _archieve[indexPath.row];

		guard
			let auth = Auth.auth().currentUser,
			let uid = data["uid"] as? String
		else { return; };

		ref.child("chatbox/\(auth.uid)/\(uid)").updateChildValues([
			"isArchieve": false
		]) { err, ref in
			self.listTableV.reloadData();
		};
	};
};
