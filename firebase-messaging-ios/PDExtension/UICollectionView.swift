/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import UIKit

extension UICollectionView {
	
	@objc convenience public init(_ x: CGFloat,_ y: CGFloat,_ w: CGFloat,_ h: CGFloat,_ layout: UICollectionViewLayout) { self.init(frame: CGRect(x: x, y: y, width: w, height: h), collectionViewLayout: layout); };

	public func proto(_ delegate: UICollectionViewDelegate,_ dataSource: UICollectionViewDataSource) -> Self { self.delegate = delegate; self.dataSource = dataSource; return self; };

	public func cell(_ cell: AnyClass?,_ id: String) -> Self { self.register(cell, forCellWithReuseIdentifier: id); return self; };

	public func cell(reuse tag: String,_ indexPath: IndexPath) -> UICollectionViewCell {
		return self.dequeueReusableCell(withReuseIdentifier: tag, for: indexPath);
	};
};
