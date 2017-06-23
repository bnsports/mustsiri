//
//  AddTaskIntentHandler.swift
//  MustSiriIntent
//
//  Created by Вадим on 22/06/2017.
//  Copyright © 2017 aximedia. All rights reserved.
//

import UIKit
import Intents

class AddTaskIntentHandler: INExtension, INAddTasksIntentHandling {
    
    func handle(addTasks intent: INAddTasksIntent, completion: @escaping (INAddTasksIntentResponse) -> Void) {
        let userActivity = NSUserActivity.init(activityType: NSStringFromClass(INAddTasksIntent.self))
        let title = intent.taskTitles?.first
        let task = INTask.init(title: title!, status: INTaskStatus.notCompleted, taskType: INTaskType.notCompletable, spatialEventTrigger: nil, temporalEventTrigger: nil, createdDateComponents: nil, modifiedDateComponents: nil, identifier: nil)
        
        let siriManager = SiriNotesHandler.init()
        let defaults = GroupUserDefaults()
        
        Logger.println("SiriIntent :: Add movie : ", title!, "To list:", intent.targetTaskList?.title as Any)
        siriManager.addMovie(movie: title!, to: (intent.targetTaskList?.title)!) { (success, error, response) in
            defaults.titleDisambiguation = false
            defaults.listDisambiguation = false
            
            if (success) {
                Logger.println("SiriIntent :: Add movie succeed")
                let response = INAddTasksIntentResponse.init(code: .success, userActivity: userActivity)
                response.addedTasks = [task]
                completion(response)
            } else {
                Logger.println("SiriIntent :: Add movie failed")
                let response = INAddTasksIntentResponse.init(code: .failure, userActivity: userActivity)
                completion(response)
            }
        }
    }
    
    func resolveTargetTaskList(forAddTasks intent: INAddTasksIntent, with completion: @escaping (INTaskListResolutionResult) -> Void) {
        if (intent.targetTaskList != nil) {
            var resolutionResults = INTaskListResolutionResult.unsupported()
            let siriManager = SiriNotesHandler.init()
            let defaults = GroupUserDefaults()
            if let listTitle = intent.targetTaskList?.title {
                Logger.println("SiriIntent :: Resolve list name : ", listTitle)
                
                siriManager.searchList(title: listTitle, with: { (lists) in
                    Logger.println("SiriIntent :: Lists found from API : ", lists)
                    var tasksLists : [INTaskList] = []
                    for list in lists {
                        let taskList = INTaskList.init(title: list, tasks: [], groupName: nil, createdDateComponents: nil, modifiedDateComponents: nil, identifier: nil)
                        tasksLists.append(taskList)
                    }
                    switch lists.count {
                    case 2 ... Int.max:
                        if (defaults.listDisambiguation == true) {
                            
                            if let title = intent.targetTaskList?.title {
                                Logger.println("SiriIntent :: Resolve list name: disambiguation resolved, result title : ", title)
                                
                                let taskList = INTaskList.init(title: title, tasks: [], groupName: nil, createdDateComponents: nil, modifiedDateComponents: nil, identifier: nil)
                                
                                resolutionResults = INTaskListResolutionResult.success(with: taskList)
                                completion(resolutionResults)
                            } else {
                                Logger.println("SiriIntent :: Resolve list name: disambiguation resolved, result title not found")
                                
                                defaults.listDisambiguation = false
                                resolutionResults = INTaskListResolutionResult.unsupported()
                                completion(resolutionResults)
                            }
                            return
                        }
                        
                        defaults.listDisambiguation = true
                        Logger.println("SiriIntent :: Resolve list name: Send response with disambiguation")
                        resolutionResults = INTaskListResolutionResult.disambiguation(with: tasksLists)
                    case 1:
                        Logger.println("SiriIntent :: Resolve list name: Send response with success")
                        resolutionResults = INTaskListResolutionResult.success(with: tasksLists.first!)
                    case 0:
                        Logger.println("SiriIntent :: Resolve list name: Send response with unsupported")
                        resolutionResults = INTaskListResolutionResult.unsupported()
                    default:
                        break
                    }
                    
                    completion(resolutionResults)
                })
            }
            
            
        } else {
            Logger.println("SiriIntent :: Resolve list name: Send response with needs value")
            
            completion(INTaskListResolutionResult.needsValue())
        }
    }
    
    func resolveTaskTitles(forAddTasks intent: INAddTasksIntent, with completion: @escaping ([INStringResolutionResult]) -> Void) {
        if (intent.taskTitles != nil) {
            Logger.println("SiriIntent :: Resolve movie title : ", intent.taskTitles?.joined() as Any)
            var resolutionResults = [INStringResolutionResult]()
            let siriManager = SiriNotesHandler.init()
            let defaults = GroupUserDefaults()
            
            siriManager.searchMovie(title: (intent.taskTitles?.joined())!) { (movies) in
                Logger.println("SiriIntent :: Movies found from API : ", movies)
                switch movies.count {
                case 2 ... Int.max:
                    if (defaults.titleDisambiguation == true) {
                        if let title = intent.taskTitles?.first {
                            Logger.println("SiriIntent :: Resolve movie title: disambiguation resolved, result title : ", title)
                            
                            resolutionResults += [INStringResolutionResult.success(with: title)]
                            completion(resolutionResults)
                        } else {
                            Logger.println("SiriIntent :: Resolve movie title: disambiguation resolved, movie not found")
                            
                            defaults.titleDisambiguation = false
                            resolutionResults += [INStringResolutionResult.unsupported()]
                            completion(resolutionResults)
                        }
                        return
                    }
                    
                    defaults.titleDisambiguation = true
                    Logger.println("SiriIntent :: Resolve movie title: Send response with disambiguation")
                    resolutionResults += [INStringResolutionResult.disambiguation(with: movies)]
                case 1:
                    Logger.println("SiriIntent :: Resolve movie title: Send response with success")
                    resolutionResults += [INStringResolutionResult.success(with: movies.first!)]
                case 0:
                    Logger.println("SiriIntent :: Resolve movie title: Send response with unsupported")
                    resolutionResults += [INStringResolutionResult.unsupported()]
                default:
                    break
                }
                completion(resolutionResults)
            }
        } else {
            Logger.println("SiriIntent :: Resolve movie title: Send response with needs value")
            completion([INStringResolutionResult.needsValue()])
        }
    }
}
