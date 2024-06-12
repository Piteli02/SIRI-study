//
//  ContentView.swift
//  SiriAndAPI
//
//  Created by Caio Gomes Piteli on 11/06/24.
//

import SwiftUI

struct ContentView: View {
    let apiManager = APIManager()
    @State private var user: GitHubUser?
    @State var userNameToSearch = "Piteli02"
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .center){
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                } placeholder:{
                    Rectangle()
                }
                .frame(width: geometry.size.width/2, height: geometry.size.height/4)
                .cornerRadius(10)
                .padding(.top, 20)
                
                Text(user?.login ?? "Nome do usuário")
                    .font(.title)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Repositórios públicos: \(user?.publicRepos ?? -1) ")
                            .padding(.top, 16)
                        
                        Text("Seguidores: \(user?.followers ?? -1)")
                            .padding(.top, 8)
                    }
                    Spacer()
                }
                
                Button(action: {
                    userNameToSearch = "rafachinelatto"
                }) {
                    Text("Change name to search")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                
            }.onChange(of: userNameToSearch){
                Task{
                    do {
                        user = try await apiManager.getUser(userName: userNameToSearch)
                    }catch GHError.invalidURL{
                        print("Invalid URL")
                    }catch GHError.invalidData{
                        print("Invalid Data")
                    }catch GHError.invalidResponse{
                        print("Invalid response")
                    }catch {
                        print("Unexpected error")
                    }
                }
            }
            .task {
                do {
                    user = try await apiManager.getUser(userName: userNameToSearch)
                }catch GHError.invalidURL{
                    print("Invalid URL")
                }catch GHError.invalidData{
                    print("Invalid Data")
                }catch GHError.invalidResponse{
                    print("Invalid response")
                }catch {
                    print("Unexpected error")
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ContentView()
}
