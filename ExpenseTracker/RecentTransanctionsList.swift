//
//  RecentTransanctionsList.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 01/04/23.
//

import SwiftUI
struct RecentTransanctionsList: View {
    @EnvironmentObject var transanctionListVM: TransanctionListViewModel

    var body: some View {
        VStack
        {
            HStack {
                // MARK: Header Title
                Text ("Recent Transanctions")
                    .bold ()
                Spacer ()
                // MARK: Header Link
                NavigationLink {
                    TransanctionList()
                } label: {
                    HStack(spacing: 4) {
                        Text ("See All")
                        Image (systemName: "chevron.right" )
                            
                            
                    }.foregroundColor (Color.text)
                }
            }.padding (.top)
            
            
            //Mark : Recent Transanction List
            ForEach(Array(transanctionListVM.transanctions.prefix(5).enumerated()), id: \.element){ index , transanction in TransanctionRow(transanction: transanction)
                
                Divider()
                    .opacity(index == 4 ? 0 : 1)
                
            }
            
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape (RoundedRectangle (cornerRadius: 20, style: .continuous) )
        .shadow (color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransanctionsList_Previews: PreviewProvider {
    static let transanctionListVM: TransanctionListViewModel = {
        let transanctionListVM = TransanctionListViewModel()
        transanctionListVM.transanctions = transanctionListPreviewData
        return transanctionListVM
    }()
    static var previews: some View {
        RecentTransanctionsList()
            .environmentObject(transanctionListVM)
    }
}
