//
//  StringExtension.swift
//  LBU25
//
//  Created by liubo on 2017/10/9.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation

extension String {
    public func substring(from index: Int) -> String {
        if self.count > index {
            let startIndex = self.index(self.startIndex, offsetBy: index)
            let subString = self[startIndex..<self.endIndex]
            return String(subString)
        } else {
            return self
        }
    }
}
