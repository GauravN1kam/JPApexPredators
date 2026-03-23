import Foundation

class Predators {
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    init() {
        decodeApexPredatorData()
    }
    
    func decodeApexPredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Error Decoing json data: \(error)")
            }
        }
    }
    
    func search(for seachTerm: String) -> [ApexPredator] {
        if seachTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter {
                $0.name.lowercased().contains(seachTerm.lowercased())
            }
        }
    }
    
    func sort(by alphabetical: Bool)
    {
        return apexPredators.sort{ pred1, pred2 in
            if alphabetical {
                return pred1.name < pred2.name
            } else {
                return pred1.id < pred2.id
            }
        }
    }
    
    func filter(by type: APType)
    {
        if type == .all {
            apexPredators = allApexPredators
        }
        else {
            apexPredators = allApexPredators.filter{ predator in
                predator.type == type
            }
        }
    }
}
