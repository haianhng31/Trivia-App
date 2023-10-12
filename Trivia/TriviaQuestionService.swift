//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Hai Anh on 10/10/2023.
//

import Foundation

class TriviaQuestionService {
    static let shared = TriviaQuestionService()
    private init() {}
    //private let baseURL = "https://opentdb.com/api.php?"
    private let urlString = "https://opentdb.com/api.php?amount=5&type=multiple"

    
    func fetchTriviaQuestion(completion: @escaping (Result<[TriviaQuestion], Error>) -> Void) {
    //(amount: Int, category: String, difficulty: String, completion: @escaping ([TriviaQuestion]?, Error?) -> Void) {
        //let endpoint = baseURL + "amount=5"
        // baseURL + "amount=\(amount)&category=\(category)&difficulty=\(difficulty)"
        // https://opentdb.com/api.php?amount=5

        guard let url = URL(string: urlString) else {
                    completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
                    return
                }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 1002, userInfo: nil)))
                return
            }
            
            do {
                let triviaResponse = try JSONDecoder().decode(TriviaAPIResponse.self, from: data)
                completion(.success(triviaResponse.questions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
            
        /*
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                //print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No Data", code: 1, userInfo: nil))
                return
            }
            
            do {
                let triviaQuestions = try JSONDecoder().decode([TriviaQuestion].self, from: data)
                if let triviaQuestion = triviaQuestions.first {
                    completion(triviaQuestions, nil)
                }
                
            } catch {
                completion(nil, error)
                //print(error.localizedDescription)
            }
        }
        
        task.resume() */
    }
}
        
        /*
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard error == nil else { return }
            guard let data else { return }
            let decoder = JSONDecoder()
            
            do {
                let triviaQuestions = try decoder.decode([OpenTriviaQuestion].self, from: data)
                if let triviaQuestion = triviaQuestions.first {
                    completion(.failure(err))
                }
            }
            .resume() */
        


