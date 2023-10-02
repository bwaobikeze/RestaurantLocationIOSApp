//
//  DetailView.swift
//  Exercise5_waobikeze_Brian
//
//  Created by brian waobikeze on 10/1/23.
//

import SwiftUI

struct DetailView: View {
    @State var map:URL? = URL(string: "")
    @State var imageTitle: URL? = URL(string: "")
    @State var title: String = ""
    @State var describ: String = ""
    @State var phone: String = ""
    @Environment(\.verticalSizeClass) var heightSize: UserInterfaceSizeClass?
    @Environment(\.horizontalSizeClass) var widthSize: UserInterfaceSizeClass?
    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        if heightSize == .regular{
            VStack{
                Spacer()
                AsyncImage(url: map){ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 350, maxHeight: 350)

                }placeholder: {
                    ProgressView()
                }
                AsyncImage(url: imageTitle){ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 150, maxHeight: 150)
                }placeholder: {
                    ProgressView()
                }
                Spacer()
                Text("P: "+title).bold()
                Spacer()
                Text(describ).multilineTextAlignment(.center).padding(.horizontal)
                Text(phone).multilineTextAlignment(.center)
                Spacer()
                Spacer()
            }
        }else if heightSize == .compact{
            HStack(spacing: 8){
                AsyncImage(url: map){ image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 350, maxHeight: 350)

                }placeholder: {
                    ProgressView()
                }
                VStack{
                    AsyncImage(url: imageTitle){ image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 150, maxHeight: 150)
                    }placeholder: {
                        ProgressView()
                    }
                    Spacer()
                    Text("P: "+title).bold()
                    Spacer()
                    Text(describ).multilineTextAlignment(.center).padding(.horizontal)
                    Text(phone).multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
