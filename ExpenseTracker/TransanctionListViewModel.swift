//
//  TransanctionListViewModel.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 01/04/23.
//

import Foundation
import Combine
import Collections
import SwiftUI


typealias TransanctionGroup = OrderedDictionary<String,[Transanction]>
typealias TransanctionPrefixSum = [(String, Double)]

final class TransanctionListViewModel: ObservableObject {
    @Published var transanctions: [Transanction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransanction()
    }
    
    func getTransanction(){
        guard let url  = URL(string: "https://designcode.io/data/transactions.json") else {
            print("invalid url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transanction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("error fetching transanctions: ", error.localizedDescription)
                case .finished :
                    print("finished fetching transanction")
                
                }
            } receiveValue: { [weak self] result in
                self?.transanctions = result
                dump(self?.transanctions)
            }
            .store(in: &cancellables)

    }
    
    func groupTransanctionByMonth() -> TransanctionGroup {
        guard !transanctions.isEmpty else {return [:]}
        let groupedTransanctions = TransanctionGroup(grouping: transanctions) { $0.month}
        return groupedTransanctions
    }
    
    func accumulateTransanctions() -> TransanctionPrefixSum{
        guard !transanctions.isEmpty else { return [] }
        
        let today  = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum : Double = .zero
        var cumulativeSum = TransanctionPrefixSum()
        
        for date in stride(from: dateInterval.start, to : today , by: 60*60*24){
            let dailyExpenses = transanctions.filter{ $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0){ $0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
        }
        return cumulativeSum
    }
}
