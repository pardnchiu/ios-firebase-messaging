/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth
import CoreImage.CIFilterBuiltins

class qrcodeVC: UIViewController {

	var qrcodeV			: UIImageView!
	var hintLbl			: UILabel!
	var buttonStackV: UIStackView!
	var shareBtn		: UIButton!
	var downloadBtn	: UIButton!
	var scannerBtn	: UIButton!

	override func viewDidLoad() {
		super.viewDidLoad();

		let isDark = traitCollection.userInterfaceStyle == .dark;

		guard let uid = Auth.auth().currentUser?.uid else { return; };

		qrcodeV = UIImageView(0, 0, vw - 120, vw - 120)
			.img(buildQRCode(uid, width: vw - 120, height: vw - 120), mode: .scaleAspectFill)
			.radius(20)
			.clip(view: true)

		hintLbl = UILabel(0, 0, vw, 30)
			.text(uid, color: _darkGray, align: .center, row: 1, wrap: .byClipping)

		buttonStackV = UIStackView(axis: .horz, align: .left, gap: 30);

		shareBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "square.and.arrow.up.on.square"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40);

		downloadBtn = UIButton()
			.text(color: _black)
			.img(UIImage(sys: "tray.and.arrow.down"))
			.bg(color: _gray)
			.radius(20)
			.Weq(40)
			.Heq(40);

		scannerBtn = UIButton()
			.touch(down: self, #selector(openScannerVC))
			.text("掃描條碼", color: _black)
			.font(weight: .medium, size: 18)
			.img(UIImage(sys: "qrcode.viewfinder"), align: .left, gap: 10)
			.bg(color: _gray)
			.radius(5)

		_=view
			.child([
				UIVisualEffectView(style: isDark ? .dark : .extraLight)
					.frame(0, 0, vw, vh),
				qrcodeV,
				hintLbl,
				buttonStackV
					.child([
						shareBtn,
						downloadBtn
					]),
				scannerBtn
			]);

		_=qrcodeV
			.Xeq(X: view)
			.Teq(T: view, 80)
			.Weq(vw - 120)
			.Heq(vw - 120);

		_=hintLbl
			.Xeq(X: view)
			.Teq(B: qrcodeV, 10)
			.Weq(vw);

		_=buttonStackV
			.Xeq(X: view)
			.Teq(B: hintLbl, 40);

		_=scannerBtn
			.Xeq(X: view)
			.Beq(B: view, -60)
			.Weq(vw - 120)
			.Heq(40)
	};

	@objc func openScannerVC() {
		let vc = scannerVC();
		present(vc, animated: true);
	};

	func buildQRCode(_ txt: String, width: CGFloat, height: CGFloat) -> UIImage? {
		let data = txt.data(using: .utf8);

		let filter = CIFilter.qrCodeGenerator();
		filter.setDefaults()
		filter.setValue(data, forKey: "inputMessage")

		guard let ciimage = filter.outputImage else { return nil; };

		let scaleX: CGFloat = width / ciimage.extent.size.width;
		let scaleY: CGFloat = height / ciimage.extent.size.height;
		let scaleResult = ciimage.transformed(by: CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY));

		return UIImage(ciImage: scaleResult);
	};
};
