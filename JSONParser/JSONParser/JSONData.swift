//
//  JSONData.swift
//  JSONParser
//
//  Created by 심 승민 on 2017. 11. 6..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

struct JSONData {
    typealias Object = [String:Any]
    typealias Array = [Any]
    typealias Number = Int
    enum DataType {
        case array
        case object
    }
    // 데이터 타입 저장. - Array, Object
    private(set) var dataType: DataType
    // 각 데이터를 타입별로 저장.
    private(set) var object: Object
    private(set) var objectCount: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int) = (0, 0, 0, 0, 0)
    // object 항목의 array 데이터.
    private(set) var array: Array
    private(set) var arrayCount: (string: Int, number: Int, bool: Int, nestedObject: Int, nestedArray: Int) = (0, 0, 0, 0, 0)
    // 전체 데이터 개수.
    var count: Int {
        var result = 0
        switch dataType {
        case .array: result = self.array.count
        case .object: result = self.object.count
        }
        return result
    }
    
    mutating func setCounts(of objects: Object) {
        for value in objects.values {
            switch value {
            case is String: self.objectCount.string += 1
            case is Number: self.objectCount.number += 1
            case is Bool: self.objectCount.bool += 1
            case is Array: self.objectCount.nestedArray += 1
            case is Object: self.objectCount.nestedObject += 1
            default: break
            }
        }
    }
    
    mutating func setCounts(of arrays: Array) {
        for value in arrays {
            switch value {
            case is String: self.arrayCount.string += 1
            case is Number: self.arrayCount.number += 1
            case is Bool: self.arrayCount.bool += 1
            case is Array:
                // 중첩배열의 값이 딕셔너리 형태이면, 중첩객체로 판단.
                guard let elem = value as? [(key: String, value: Any)] else { self.arrayCount.nestedArray += 1; continue }
                self.arrayCount.nestedObject += 1
            default: break
            }
        }
    }
    
    init() {
        self.dataType = DataType.array
        self.object = [:]
        self.array = []
    }
    
    mutating func setData(_ data: [String:Any]) {
        self.dataType = DataType.object
        for (key, value) in data {
            self.object.updateValue(value, forKey: key)
        }
        setCounts(of: data)
    }
    
    mutating func setData(_ data: [Any]) {
        self.dataType = DataType.array
        for value in data {
            self.array.append(value)
        }
        setCounts(of: data)
    }
    
}
