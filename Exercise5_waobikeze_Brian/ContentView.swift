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
    @Environment(\.verticalSizeClass) var heightSize: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthSize: UserInterfaceSizeClass?
    @State private var Restrunts = [restrunts]()
    var body: some View {
        if heightSize == .regular{
            NavigationView{
                List(Restrunts, id: \.name) { rest in
                    NavigationLink(destination: DetailView(map: rest.map, imageTitle: rest.logo, title: rest.name, describ: rest.about,phone: rest.phone)){
                        HStack{
                            AsyncImage(url: rest.logo){ image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 120, maxHeight: 120)
                                
                            }placeholder: {
                                ProgressView()
                            }
                            Spacer()
                            Text(rest.free).font(.title.bold())
                        }
                    }
                    Spacer()
                }
                .task {
                    await loadData()
                }
                
            }
        }else if heightSize == .compact{
            NavigationView{
                List(Restrunts, id: \.name) { rest in
                    NavigationLink(destination: DetailView(map: rest.map, imageTitle: rest.logo, title: rest.name, describ: rest.about,phone: rest.phone)){
                        HStack{
                            AsyncImage(url: rest.logo){ image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 120, maxHeight: 120)
                                
                            }placeholder: {
                                ProgressView()
                            }
                            Spacer()
                            Text(rest.free).font(.title.bold())
                        }
                    }
                    Spacer()
                }
                .listStyle(PlainListStyle())
                .task {
                    await loadData()
                }
                
            }
            
            
        }

    }
    func loadData() async {
       
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
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            ContentView()
//        }
//    }

