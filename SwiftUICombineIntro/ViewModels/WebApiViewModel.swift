//
//  WebApiViewModel.swift
//  SwiftUICombineIntro
//
//  Created by Kaori Persson on 2022-06-10.
//

import Foundation
import Combine

final class WebApiViewModel: ObservableObject {
    
    // MARK: - Properties
    
    // With @Published, the property offers publisher.
    // when the value is changed,
    // The view will be rendered again
    @Published var joke: String = ""
    
    private var cancellables: [AnyCancellable] = []
    
    // Cancel all subscription at the timing of deinit
    deinit {
        cancellables.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    func fetchJoke() {
        guard let url = URL(string: "https://icanhazdadjoke.com/") else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        // dataTaskPublisher is publisher
        URLSession.shared.dataTaskPublisher(for: urlRequest)
        // tryMap is operater
            .tryMap { (data:Data, _: URLResponse) in
                return data
            }
            .decode(type: JokeResponse.self,
                    decoder: JSONDecoder())
        // Change the process thread to the main thread
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Finished")
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                },
                receiveValue: { [weak self] jokeResponse in
                    // The view will be re-rendered since the joke property has @Published
                    self?.joke = jokeResponse.joke
                })
            .store(in: &cancellables)
    }
    
}
