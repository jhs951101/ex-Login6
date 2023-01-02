import UIKit

class HttpController {
    
    private func jsonToDict(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    public func get(url: String, params: Dictionary<String, String>) -> [String: Any]? {
        var result: String! = nil;
        
        var urlWithParams = url
        var first: Bool = true
        
        for key in params.keys {
            var ch: String! = nil
            
            if(first){
                ch = "?"
                first = false
            }
            else{
                ch = "&"
            }
            
            urlWithParams += (ch + key + "=" + params[key]!)
        }
        
        var urlComponents = URLComponents(string: urlWithParams)
        
        var requestURL = URLRequest(url: (urlComponents?.url)!)
        requestURL.httpMethod = "GET"
        requestURL.addValue("application/x-www-form-urlencoded; charset=utf-8;", forHTTPHeaderField: "Content-Type")

        var wait: Bool = true
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil else {
                wait = false
                return
            }

            let successsRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
            else {
                wait = false
                return
            }

            result = String(data: data!, encoding: .utf8)
            wait = false
        }
        
        dataTask.resume()
        
        while(wait){}
        return jsonToDict(text: result)
    }
    
    public func post(url: String, params: Dictionary<String, String>) -> [String: Any]? {
        var result: String! = nil;
        let urlComponents = URLComponents(string: url)
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        var requestURL = URLRequest(url: (urlComponents?.url)!)
        requestURL.httpMethod = "POST"
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestURL.httpBody = jsonData

        var wait: Bool = true
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil else {
                wait = false
                return
            }

            let successsRange = 200..<300
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, successsRange.contains(statusCode)
            else {
                wait = false
                return
            }

            do {
                let jsonConvert = try JSONSerialization.jsonObject(with: data!) as! [String: Any]
                let JsonResponse = try! JSONSerialization.data(withJSONObject: jsonConvert, options: .prettyPrinted)
                let resultString = String(data: JsonResponse, encoding: .utf8)
                result = resultString
            } catch {
            }
            
            wait = false
        }

        dataTask.resume()
        
        while(wait){}
        return jsonToDict(text: result)
    }
}
