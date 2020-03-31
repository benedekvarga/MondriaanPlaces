//
//  MdcAPI.swift
//  MondriaanPlaces
//
//  Created by Benedek Varga on 2020. 03. 31..
//  Copyright © 2020. Benedek Varga. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum MdcAPI {
    case places
}

extension MdcAPI: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        switch self {
        case .places:
            return URL(string: "https://candidate.mondriaan.com/")!
        }
    }

    var path: String {
        switch self {
        case .places:
            return "places"
        }
    }

    var method: Moya.Method {
        switch self {
        case .places:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .places:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }

    var authorizationType: AuthorizationType? {
        switch self {
        case .places:
            return .basic
        }
    }

    var shouldAuthorize: Bool {
        switch self {
        case .places:
            return true
        }
    }
}

extension MdcAPI: Providing { }
