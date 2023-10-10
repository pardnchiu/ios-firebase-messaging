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

class headSelectVC: UIViewController {

	let heads: [String] = [
		"01", "3DDD-1", "3DDD-2", "3DDD-3", "3DDD-4", "3DDD",
		"Afterclap-1", "Afterclap-2", "Afterclap-3", "Afterclap-4",
		"Afterclap-5", "Afterclap-6", "Afterclap-7", "Afterclap-8",
		"Afterclap-9", "Afterclap", "Cranks-1", "Cranks-2", "Cranks",
		"Delivery boy-1", "Delivery boy-2", "Delivery boy-3", "Delivery boy-4",
		"Delivery boy-5", "Delivery boy", "E-commerce-1", "E-commerce-2", "E-commerce",
		"Funny Bunny-1", "Funny Bunny-2", "Funny Bunny-3", "Funny Bunny-4",
		"Funny Bunny-5", "Funny Bunny-6", "Funny Bunny-7", "Funny Bunny-8",
		"Funny Bunny", "Guacamole-1", "Guacamole-2", "Guacamole-3", "Guacamole",
		"Juicy-1", "Juicy", "No comments 3", "No comments 4", "No comments 5",
		"No comments 6", "No comments 7", "No comments 8", "No comments 9", "No Comments-1",
		"No Comments-2", "No Comments-3", "No Comments", "No gravity-1", "No gravity-2",
		"No gravity-3", "No gravity", "OSLO-1", "OSLO-2", "OSLO-3", "OSLO-4",
		"OSLO-5", "OSLO-6", "OSLO-7", "OSLO-8", "OSLO-9", "OSLO-10", "OSLO-11",
		"OSLO-12", "OSLO-13", "OSLO-14", "OSLO", "Teamwork-1", "Teamwork-2", "Teamwork-3",
		"Teamwork-4", "Teamwork-5", "Teamwork-6", "Teamwork-7", "Teamwork-8", "Teamwork",
		"Upstream-1", "Upstream-2", "Upstream-3", "Upstream-4", "Upstream-5", "Upstream-6",
		"Upstream-7", "Upstream-8", "Upstream-9", "Upstream-10", "Upstream-11", "Upstream-12",
		"Upstream-13", "Upstream-14", "Upstream-15", "Upstream-16", "Upstream-17", "Upstream"
	];

	var grid: UICollectionView!

	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;
		
		ref = Database.database().reference();

		let gridLayout = UICollectionViewFlowLayout()._ { e in
			let width: CGFloat = CGFloat(vw / 3)
			e.minimumLineSpacing = 0;
			e.minimumInteritemSpacing = 0;
			e.scrollDirection = .vertical;
			e.estimatedItemSize = CGSize(width, width);
		};

		grid = UICollectionView(0, 0, vw, vh, gridLayout)
			.proto(self, self)
			.cell(headCollVCell.self, "headCollectionViewCell")
			.bg(color: .clear);

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				grid
			]);

		_=grid
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);
	};

	@objc func closeSelector(_ sender: UIButton) {
		guard
			let name = sender.configuration?.background.image?.imageAsset?.value(forKey: "assetName") as? String
		else { return; };

		if let vc = presentingViewController as? signupVC {
			_=vc.headBtn
				.bg(image: UIImage(name: name), mode: .scaleAspectFit)
		}
		else if let vc = presentingViewController as? homeVC {
			_=vc.accountV.headBtn
				.img(UIImage(name: name))

			guard let auth = Auth.auth().currentUser else { return; };

			ref.child("users/\(auth.uid)").updateChildValues([
				"head": name
			], withCompletionBlock: { err, ref in
				if let err = err { return print(err.localizedDescription); };
				self.alert("成功更改頭像");
			});
		};
	};

	func alert(_ message: String) {
		let alert = UIAlertController(title: "通知", message: message, preferredStyle: .alert);
		let cancel = UIAlertAction(title: "確定", style: .cancel, handler: nil)
		alert.addAction(cancel)
		self.present(alert, animated: true);
	};
};

extension headSelectVC: UICollectionViewDelegate, UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return heads.count;
	};

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(vw / 3, vw / 3);
	};

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let data: String = heads[indexPath.row];

		guard
			let cell = collectionView.cell(reuse: "headCollectionViewCell", indexPath) as? headCollVCell
		else { return UICollectionViewCell(); };

		_=cell.headBtn
			.touch(down: self, #selector(closeSelector))
			.bg(image: UIImage(name: data), mode: .scaleAspectFit);

		return cell;
	};
};


