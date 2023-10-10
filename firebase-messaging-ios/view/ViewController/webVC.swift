/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit
import WebKit

class webVC: UIViewController {

	var webV: WKWebView!
	var url	: String!

	override func viewDidLoad() {
		super.viewDidLoad();

		webV = WKWebView()

		_=view.child([
			webV
		]);

		_=webV
			.Teq(T: view)
			.Leq(L: view)
			.Beq(B: view)
			.Req(R: view);

		guard let url = URL(string: url) else { return; };
		webV.load(URLRequest(url: url));
	};
};
