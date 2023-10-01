//
//  ContentView.swift
//  Exercise5_waobikeze_Brian
//
//  Created by brian waobikeze on 9/30/23.
//

import SwiftUI


struct response: Codable{
    var results: [restrunts]
}
struct ContentView: View {
    @State private var Restrunts = [restrunts]()
    var body: some View {
            List(Restrunts, id: \.name) { rest in
                HStack{
                                        AsyncImage(url: rest.logo) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(maxWidth: 80, maxHeight: 80)
                                        } placeholder: {
                                            ProgressView()
                                        }
                    Spacer()
                    Text(rest.free).font(.title.bold())
                }
                Spacer()
            }
            .task {
                await loadData()
            }
        
    }
    func loadData() async {
        // func might want to go to sleep in order to complete work
        guard let url = URL(string: "https://m.cpl.uh.edu/courses/ubicomp/fall2022/webservice/restaurant/restaurants.json") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonDecoder = JSONDecoder()
                    Restrunts = try jsonDecoder.decode(Array<restrunts>.self, from: data)
                    
                } catch {
                    print("Error trying to decode JSON object")
                }
                
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
        
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

