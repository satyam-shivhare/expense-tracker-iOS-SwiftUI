//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 01/04/23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transanctionListVM: TransanctionListViewModel
    var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 24  ){
                    //MARK : TITLE
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    //Mark : Chart
                    let data = transanctionListVM.accumulateTransanctions()
                    
                    if !data.isEmpty {
                        
                        
                        
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "usd")), type: .title, format: "$%.02f").background (Color.systemBackground)
                                LineChart()
                                
                            }.background(Color.systemBackground)
                            
                            
                        }.data(data)
                            .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                            .frame(height: 300)
                        
                    }
                    //Mark : Transanction List
                    RecentTransanctionsList()
                } 
                .padding()
                .frame(maxWidth: .infinity)
            }.background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    //MARK : Notification icon
                    ToolbarItem{
                        Image(systemName:  "bell.badge")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.icon , .primary)
                    }
                }
        }.navigationViewStyle(.stack)
            .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transanctionListVM: TransanctionListViewModel = {
        let transanctionListVM = TransanctionListViewModel()
        transanctionListVM.transanctions = transanctionListPreviewData
        return transanctionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transanctionListVM)
    }
}
