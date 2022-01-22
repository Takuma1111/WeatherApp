//
//  SearchError.swift
//  WeatherApp
//
//  Created by 村上拓麻 on 2022/01/19.
//

import Foundation

enum SearchError : Error{
    case noInput
    case noResponse
}

extension SearchError : LocalizedError {
    var errorDescription: String?{
        switch self {
        case .noInput:
            return "市の名前を入力してください"
        case .noResponse:
            return "該当する市がありませんでした"
        }
    }
}
