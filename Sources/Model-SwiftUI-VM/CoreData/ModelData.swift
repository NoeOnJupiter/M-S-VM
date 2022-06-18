//
//  File.swift
//  
//
//  Created by Joe Maghzal on 5/7/22.
//

import SwiftUI
import Combine
import CoreData

public final class ModelData<T: Datable>: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    private var publishedData = CurrentValueSubject<[T], Never>([])
    private let fetchController: NSFetchedResultsController<T.Object>
    private init(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) {
        let fetchRequest = T.Object.fetchRequest() as! NSFetchRequest<T.Object>
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        guard let viewContext = Configurations.shared.managedObjectContext else {
            fatalError("You should set the ViewContext of the Configurations using Configurations.setObjectContext")
        }
        fetchController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: viewContext, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchController.delegate = self
        do {
            try fetchController.performFetch()
            publishedData.value = fetchController.fetchedObjects?.model() ?? []
        }catch {
            print(String(describing: error))
        }
    }
    deinit {
        print("deinited")
    }
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let data = controller.fetchedObjects as? [T.Object] else {return}
        self.publishedData.value = data.model()
    }
    func with(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = []) -> ModelData<T> {
        return ModelData(predicate: predicate, sortDescriptors: sortDescriptors)
    }
    func publisher() -> AnyPublisher<[T], Never> {
        return publishedData.eraseToAnyPublisher()
    }
    func latest<Result: Hashable & Datable>(_ publisher: Published<[Result]>.Publisher) -> AnyPublisher<[Result], Never> {
        return Publishers.CombineLatest(publisher.eraseToAnyPublisher(), publishedData.compactMap({$0.compactMap({$0 as? Result})}))
            .map { publisher1, publisher2 in
                var combined = publisher1
                combined.append(contentsOf: publisher2)
                return Array(Set(combined))
            }.eraseToAnyPublisher()
    }
}
