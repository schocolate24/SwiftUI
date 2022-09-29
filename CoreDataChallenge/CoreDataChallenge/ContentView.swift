//
//  ContentView.swift
//  CoreDataChallenge
//
//  Created by 中木翔子 on 2022/08/24.
//

import SwiftUI

struct ResponseUser: Codable {
    var resultUser: [User]
}

struct User: Codable, Hashable{
    var id: Int
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var resistered: String
    var tags: [String]
}

struct ContentView: View {
    @State private var resultUser = [User]()
    
    var body: some View {
        List(resultUser, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.company)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(ResponseUser.self, from: data) {
                resultUser = decodedResponse.resultUser
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
