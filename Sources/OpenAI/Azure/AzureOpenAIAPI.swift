//
//  AzureOpenAIAPI.swift
//
//
//  Created by James Rochabrun on 1/23/24.
//

import Foundation

// MARK: - AzureOpenAIAPI

enum AzureOpenAIAPI {
   
   static var azureOpenAIResource: String = ""
   
   // https://learn.microsoft.com/en-us/azure/ai-services/openai/assistants-reference?tabs=python
   // https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/assistant
   case assistant(AssistantCategory)
   // https://learn.microsoft.com/en-us/azure/ai-services/openai/reference#chat-completions
   case chat(deploymentID: String)
   // https://learn.microsoft.com/en-us/azure/ai-services/openai/assistants-reference-threads?tabs=python#create-a-thread
   case thread(ThreadCategory)
   
   enum AssistantCategory {
      case create
      case list
      case retrieve(assistantID: String)
      case modify(assistantID: String)
      case delete(assistantID: String)
   }
   
   enum ThreadCategory {
      case create
      case retrieve(threadID: String)
      case modify(threadID: String)
      case delete(threadID: String)
   }
}

// MARK: Endpoint

extension AzureOpenAIAPI: Endpoint {
   
   var base: String {
      "https://\(Self.azureOpenAIResource)/openai.azure.com"
   }
   
   var path: String {
      switch self {
      case .chat(let deploymentID): return "/openai/deployments/\(deploymentID)/chat/completions"
      case .assistant(let category):
         switch category {
         case .create, .list: return "/openai/assistants"
         case .retrieve(let assistantID), .modify(let assistantID), .delete(let assistantID): return "/openai/assistants/\(assistantID)"
         }
      case .thread(let category):
         switch category {
         case .create: return "/openai/threads"
         case .retrieve(let threadID), .modify(let threadID), .delete(let threadID): return "/openai/threads/\(threadID)"
         }
      }
   }
}
