//
//  APIManager.swift
//  TripPlus
//
//  Created by 유대상 on 8/25/24.
//

import Foundation
import Alamofire

// 질문 : APIManager는 보통.. api별로 각자 다른 결과값(배열, int, String 등)을 어떻게 전달해주나?

class APIManager{
    func requestAPI() async{
        let response = await AF.request("https://jsonplaceholder.typicode.com/todos/1/users")
                               // Automatic HTTP Basic Auth.
//                               .authenticate(username: "user", password: "pass")
//                               // Caching customization.
//                               .cacheResponse(using: .cache)
                               // Redirect customization.
//                               .redirect(using: .follow)
                               // Validate response code and Content-Type.
                               .validate()
                               // Produce a cURL command for the request.
//                               .cURLDescription { description in
//                                 print(description)
//                               }
                               // Automatic Decodable support with background parsing.
//                               .serializingDecodable(DecodableType.self)
                                //일단.. 이거 자료형을 어찌해야하오
        
                               // Await the full response with metrics and a parsed body.
                               .response
        // Detailed response description for easy debugging.
        debugPrint(response)
    }
}
