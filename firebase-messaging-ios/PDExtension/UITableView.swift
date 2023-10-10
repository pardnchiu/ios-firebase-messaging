/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UITableView {

	public func proto(_ delegate: UITableViewDelegate,_ dataSource: UITableViewDataSource) -> Self { self.delegate = delegate; self.dataSource = dataSource; return self; };

	public func cell(_ cell: AnyClass?,_ id: String) -> Self { self.register(cell, forCellReuseIdentifier: id); return self; };

	public func separator(color: UIColor) -> Self { self.separatorColor = color; return self; };

	public func padding(T: CGFloat) -> Self { contentInset = UIEdgeInsets(top: T, left: contentInset.left, bottom: contentInset.bottom, right: contentInset.right); return self; };
	
	public func padding(B: CGFloat) -> Self { contentInset = UIEdgeInsets(top: contentInset.top, left: contentInset.left, bottom: B, right: contentInset.right); return self; };

	override public func indicator(val: Bool) -> Self { showsVerticalScrollIndicator = val; showsHorizontalScrollIndicator = val; return self; };

	public func rowH(auto: CGFloat) -> Self { estimatedRowHeight = auto; rowHeight = UITableView.automaticDimension; return self; };
};
