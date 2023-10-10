/**
 Copyright 2023 Pardn Ltd 帕登國際有限公司.
 Created by Pardn Chiu 邱敬幃.
 Email: chiuchingwei@icloud.com
 */

import Foundation
import CommonCrypto
import UIKit

// MARK: timeStamp
struct timeBase {
	public static let m = 60;
	public static let h = 60*60;
	public static let d = 60*60*24;
	public static let D = 60*60*24*7;
	public static let M = 60*60*24*30;
	public static let y = 60*60*24*365;
};

// MARK: 字串
extension String {

	public var fit: String { return self.trimmingCharacters(in: .whitespaces); };
	public var url: URL? { return URL(string: self) };

	public func equal(_ value: String)  -> Bool { return (self == value); };
	public func differ(_ value: String) -> Bool { return (self != value); };

	public func replace(_ key: String,_ value: String) -> String {
		return self.replacingOccurrences(of: key, with: value, options: .literal, range: nil)
	};
};

// MARK: 整數
extension Int {

	var str    : String 	{ return String(self) };
	var cgFloat: CGFloat 	{ return CGFloat(self) };
	var float  : Float 		{ return Float(self) };
	var num 	 : NSNumber { return NSNumber(integerLiteral: self) };
	var double : Double 	{ return Double(integerLiteral: Int64(self)) };
	var date   : Date 		{ return Date(timeIntervalSince1970: TimeInterval(self)) };

	func equal(_ value: Int)  -> Bool { return (self == value); };
	func differ(_ value: Int) -> Bool { return (self != value); };
};

// MARK: 浮點數
extension Float {

	func equal(_ value: Float)  -> Bool { return (self == value); };
	func differ(_ value: Float) -> Bool { return (self != value); };
};

// MARK: 日期
extension Date {

	var int: Int { return Int(self.timeIntervalSince1970); };
	var gone: String {
		switch (Date().int - self.int) {
			case let i where (i < timeBase.m)   	: return "剛剛";
			case let i where (i / timeBase.m < 60): return "\(i/timeBase.m)分鐘";
			case let i where (i / timeBase.h < 24): return "\(i/timeBase.h)小時";
			case let i where (i / timeBase.d < 30): return "\(i/timeBase.d)天";
			case let i where (i / timeBase.d < 30): return "\(i/timeBase.D)週";
			case let i where (i / timeBase.M < 12): return "\(i/timeBase.M)個月";
			case let i where (i / timeBase.y > 1) : return "\(i/timeBase.y)年";
			default                               : return "";
		};
	};
	var left: String {
		let date: Int 		= self.int
		let d 	: String 	= (date / timeBase.d).differ(0) ? "\(date / timeBase.d)d-" : "";
		let h		: String 	= ((date % timeBase.d) / timeBase.h).differ(0) ? "\((date % timeBase.d) / timeBase.h)h-" : "";
		let m 	: String 	= (((date % timeBase.d) % timeBase.h) / timeBase.m).differ(0) ? "\(((date % timeBase.d) % timeBase.h) / timeBase.m)m-" : "";
		let s 	: String 	= (((date % timeBase.d) % timeBase.h) % timeBase.m).differ(0) ? "\(((date % timeBase.d) % timeBase.h) % timeBase.m)s" : "";
		return "\(d)\(h)\(m)\(s)";
	};

	func equal(_ date: Date) 	-> Bool { return (self == date) };
	func differ(_ date: Date) -> Bool { return (self != date) };
};

// MARK: 資料
extension Data {

	var str: String { return (String(bytes: self, encoding: .utf8) ?? ""); };
	var json: [String:Any] {
		do {
			let dic = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? [String:Any]
			return dic ?? [:]
		} catch {
			return [:];
		};
	};

	mutating func add(_ value: String, using encoding: String.Encoding = .utf8) {
		if let data = value.data(using: encoding) {
			append(data)
		}
	}
};

// MARK: CGFLoat
extension CGFloat {

	var int: Int { return Int(self) };

	func equal(_ value: CGFloat)  -> Bool { return (self == value); };
	func differ(_ value: CGFloat) -> Bool { return (self != value); };
};

// MARK: NSNumber
public extension NSNumber {
	var int: Int { return Int(truncating: self); };
};
