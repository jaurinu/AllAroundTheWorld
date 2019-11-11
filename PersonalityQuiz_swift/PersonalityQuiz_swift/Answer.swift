//
//  Answer.swift
//  PersonalityQuiz_swift
//
//  Created by Apple Device 9 on 11/8/19.
//  Copyright © 2019 jun. All rights reserved.
//

import Foundation

struct Answer {
    var text: String
    var type: Type
}

enum Type {
    case resultado1
    case resultado2
    case resultado3
    case resultado4
    
    var definition: String {
        switch self {
        case .resultado1:
            return "Resultado 1"
        case .resultado2:
            return "Resultado 2"
        case .resultado3:
            return "Resultado 3"
        case .resultado4:
            return "Resultado 4"
        }
    }
}





