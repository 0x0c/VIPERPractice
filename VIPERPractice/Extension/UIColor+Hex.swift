//
//  UIColor+Hex.swift
//  VIPERPractice
//
//  Created by Akira Matsuda on 2023/06/07.
//

import UIKit

extension UIColor {
    // https://tech.amefure.com/swift-color-hexadecimal
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        // 不要なスペースや改行があれば除去
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // スキャナーオブジェクトの生成
        let scanner = Scanner(string: hexString)

        // 先頭(0番目)が#であれば無視させる
        if hexString.hasPrefix("#") {
            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        }

        var color: Int64 = 0
        // 文字列内から16進数を探索し、Int64型で color変数に格納
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    // https://pype.org/swift-uicolor-to-hex/
    func toHex(alpha: Bool = false) -> String {
        guard let components = cgColor.components, components.count >= 3 else {
            return "ffffff"
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)

        if components.count >= 4 {
            a = Float(components[3])
        }

        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        }
        else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
}
