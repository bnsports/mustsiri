//
//  JSONable.swift
//  MustSiriSpotlight
//
//  Created by Вадим on 19/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import Foundation

protocol JSONAble {}

extension JSONAble {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
