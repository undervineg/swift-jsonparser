//
//  main.swift
//  JSONParser
//
//  Created by 심 승민 on 11/06/2017.
//  Copyright © 2017 심 승민. All rights reserved.
//

import Foundation

func main() throws {
    while true {
        do {
            guard let userInput = try InputView.askFor(message: "분석할 JSON 데이터를 입력하세요: ") else { return }
            let jsonData = JSONParser.parse(from: userInput)
            OutputView.printDataReport(of: jsonData)
        }catch let e as JSONParser.JsonError {
            OutputView.printError(e)
            continue
        }
    }
}

try main()
