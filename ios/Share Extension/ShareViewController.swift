//
//  ShareViewController.swift
//  Share Extension
//
//  Created by tuvh on 09/01/2025.
//

import receive_sharing_intent

class ShareViewController: RSIShareViewController {


      override func shouldAutoRedirect() -> Bool {
          return false
      }

      // Use this to change label of Post button
//       override func presentationAnimationDidFinish() {
//           super.presentationAnimationDidFinish()
//           navigationController?.navigationBar.topItem?.rightBarButtonItem?.title = "Send"
//       }

}
