//
//  Endpoints.swift
//  LessLinesDemo
//
//  Created by Mustafa Baalbaki on 11/15/18.
//  Copyright © 2018 Mustafa. All rights reserved.
//

import Foundation
import SwiftyJSON

enum Endpoints {
    case photosList
}

extension Endpoints {
    var endPoint: Endpoint<JSON> {
        switch self {
        case .photosList:
            return Endpoint(url: URLFactory.getURL(path: "photos")!) { JSON($0) }
        }
    }
}
