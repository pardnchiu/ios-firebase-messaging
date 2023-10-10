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
import AVFoundation

class scannerVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

	var capture = AVCaptureSession();

	var preview	: AVCaptureVideoPreviewLayer?
	var frameV	: UIView?
	var pause		: Bool = false;

	var ref: DatabaseReference!

	override func viewDidLoad() {
		super.viewDidLoad()

		ref = Database.database().reference();

		guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return; };

		do {
			let input = try AVCaptureDeviceInput(device: device);
			capture.addInput(input);
		} catch {
			print(error.localizedDescription);
			return;
		};

		let output = AVCaptureMetadataOutput();
		capture.addOutput(output);

		output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main);
		output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr];

		preview = AVCaptureVideoPreviewLayer(session: capture);
		preview?.videoGravity = AVLayerVideoGravity.resizeAspectFill;
		preview?.frame = view.layer.bounds;
		view.layer.addSublayer(preview!);

		capture.startRunning();

		frameV = UIView();

		if let qrcode = frameV {
			qrcode.layer.borderColor = UIColor.green.cgColor;
			qrcode.layer.borderWidth = 3;
			view.addSubview(qrcode);
			view.bringSubviewToFront(qrcode);
		};
	};

	func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
		if (metadataObjects.count == 0) { frameV?.frame = .zero; return; };

		let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
		if metadataObj.type == AVMetadataObject.ObjectType.qr {
			let barCodeObject = preview?.transformedMetadataObject(for: metadataObj)
			frameV?.frame = barCodeObject!.bounds

			if metadataObj.stringValue != nil && !pause {
				pause = true;
				let uid = metadataObj.stringValue ?? ""
				ref.child("users").child(uid).observeSingleEvent(of: .value, with: { snap in
					let data = snap.value as? [String:Any] ?? [:];
					let head = data["head"] as? String ?? "";
					let name = data["name"] as? String ?? "";

					let vc = userVC();
					vc.uid = uid;
					vc.head = head;
					vc.name = name;
					self.present(vc, animated: true);
				});
			};
		};
	};
};
