//
//  TransanctionList.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 02/04/23.
//

import SwiftUI

struct TransanctionList: View {
    @EnvironmentObject var transanctionListVM: TransanctionListViewModel
    var body: some View {
        VStack{
            List{
                //Mark : Transanction Group
                ForEach(Array(transanctionListVM.groupTransanctionByMonth()) , id: \.key){
                    month, transanctions in
                    Section {
                        //Mark : Transanction List
                        ForEach(transanctions){ transanction in
                            TransanctionRow(transanction:  transanction )
                        }
                    } header: {
                        //Mark : Transanction Month
                        Text(month)
                    }.listSectionSeparator(.hidden)

                }
            }.listStyle(.plain)
        }.navigationTitle("Transanctions")
            .navigationBarTitleDisplayMode(.inline )
    }
}

struct TransanctionList_Previews: PreviewProvider {
    static let transanctionListVM: TransanctionListViewModel = {
        let transanctionListVM = TransanctionListViewModel()
        transanctionListVM.transanctions = transanctionListPreviewData
        return transanctionListVM
    }()
    static var previews: some View {
        NavigationView{
            TransanctionList()
        }.environmentObject(transanctionListVM)
    }
}
