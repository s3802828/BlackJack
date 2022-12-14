/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Le Quynh Giang
  ID: s3802828
  Created  date: 18/08/2022
  Last modified: 19/08/2022
  Acknowledgement:
 P.Hudson. "How to detect dark mode" Hacking with Swift. https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-dark-mode (accessed Aug. 18, 2022)
*/

import SwiftUI

struct LeaderBoardView: View {
    @Environment(\.colorScheme) var colorScheme
    let userArray : [Dictionary<String, Any>] = UserDefaults.standard.array(forKey: "userInfo") as? [Dictionary<String, Any>] ?? [];
    @State var sortedUserArray : [Dictionary<String, Any>] = []
    var body: some View {
        ZStack{
            colorScheme == .dark ? Color.white.edgesIgnoringSafeArea(.all) : Color.black.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack (spacing: 0){
                    LeaderBoardTitle(titles: ["Rank", "Username", "Coins"])
                    if sortedUserArray.count > 0 {
                        ForEach(sortedUserArray.indices, id:\.self){idx in
                            LeaderBoardRow(order: idx + 1, username: sortedUserArray[idx]["username"] as! String, coin: sortedUserArray[idx]["highestCoin"] as! Int)
                        }
                    }
                }
            }.onAppear(){
                //Sort the user array according to the highest score of each user.
                sortedUserArray = userArray.sorted{
                    $0["highestCoin"] as! Int > $1["highestCoin"] as! Int
                }
            }
        }
        
        
    }
}
//MARK: LEADERBOARD ROW
struct LeaderBoardRow: View {
    let order : Int
    let username: String
    let coin: Int
    var body: some View{
        HStack (alignment: .center){
            //If the order is 1, 2, 3, show the corresponding badge
            if order < 4 {
                Image(order == 1 ? "1st" : (order == 2 ? "2nd" : "3rd"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/3, height: 50)
            } else { //Otherwise, show the order number with gray circle
                Circle()
                    .fill(ColorConstants.lightGray)
                    .frame(width: UIScreen.main.bounds.width/3, height: 50)
                    .overlay(Text("\(order)").font(.system(size: 25)))
            }
            Text(username)
                .font(.system(size: 20))
                .frame(width: UIScreen.main.bounds.width/3, alignment: .center)
            Text("$\(coin)")
                .font(.system(size: 20))
                .frame(width: UIScreen.main.bounds.width/3, alignment: .center)
                .padding(.trailing, 20)
        }.padding(.all, 20)
            .background(order % 2 == 0 ? ColorConstants.lightGold : ColorConstants.boldGold)
    }
}
//MARK: LEADERBOARD COLUMMN TITLE
struct LeaderBoardTitle: View {
    let titles : [String]
    var body: some View{
        HStack (alignment: .top){
            Spacer()
            ForEach(titles, id: \.self){title in
                Text(title)
                    .font(.system(size: 25))
                    .frame(width: UIScreen.main.bounds.width/3, alignment: .center)
                    
            }
        }
        .padding(.all, 20)
        .padding(.horizontal, 20)
        .background(ColorConstants.shinyGold)
    }
}

struct LeaderBoardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoardView()
    }
}
