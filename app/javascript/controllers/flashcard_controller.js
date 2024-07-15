// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static targets = ["card", "progress"]

//   connect() {
//     this.currentIndex = 0
//     this.updateProgress()
//   }

//   flipCard(event) {
//     event.currentTarget.classList.toggle("flipped")
//   }

//   markKnown() {
//     this.updateReview(true)
//   }

//   markUnknown() {
//     this.updateReview(false)
//   }

//   async updateReview(known) {
//     const currentCard = this.cardTargets[this.currentIndex]
//     const reviewId = currentCard.dataset.reviewId

//     try {
//       const response = await fetch(`/reviews/${reviewId}`, {
//         method: 'PATCH',
//         headers: {
//           'Content-Type': 'application/json',
//           'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
//         },
//         body: JSON.stringify({ known: known })
//       })

//       if (response.ok) {
//         const data = await response.json()
//         if (known && this.shouldRemoveCard(data.next_review_date)) {
//           this.removeCurrentCard()
//         } else {
//           this.showNextCard()
//         }
//       } else {
//         console.error('Failed to update review')
//       }
//     } catch (error) {
//       console.error('Error updating review:', error)
//     }
//   }

//   shouldRemoveCard(nextReviewDate) {
//     const tomorrow = new Date()
//     tomorrow.setDate(tomorrow.getDate() + 1)
//     tomorrow.setHours(0, 0, 0, 0)
//     return new Date(nextReviewDate) >= tomorrow
//   }

//   removeCurrentCard() {
//     const currentCard = this.cardTargets[this.currentIndex]
//     currentCard.remove()
    
//     if (this.currentIndex >= this.cardTargets.length) {
//       this.currentIndex = 0
//     }

//     if (this.cardTargets.length > 0) {
//       this.cardTargets[this.currentIndex].classList.remove('hidden')
//       this.updateProgress()
//     } else {
//       this.showCompletionMessage()
//     }
//   }

//   showNextCard() {
//     this.cardTargets[this.currentIndex].classList.add('hidden')
//     this.currentIndex = (this.currentIndex + 1) % this.cardTargets.length
//     this.cardTargets[this.currentIndex].classList.remove('hidden')
//     this.updateProgress()
//   }

//   updateProgress() {
//     this.progressTarget.textContent = `Card ${this.currentIndex + 1} of ${this.cardTargets.length}`
//   }

//   showCompletionMessage() {
//     this.progressTarget.textContent = "Great job! You've completed all the flashcards."
//   }
// }

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "progress"]

  connect() {
    this.currentIndex = 0
    this.totalCards = this.cardTargets.length
    this.updateProgress()
  }

  flipCard(event) {
    event.currentTarget.classList.toggle("flipped")
  }

  markKnown() {
    this.updateReview(true)
  }

  markUnknown() {
    this.updateReview(false)
  }

  async updateReview(known) {
    const currentCard = this.cardTargets[this.currentIndex]
    const reviewId = currentCard.dataset.reviewId

    try {
      const response = await fetch(`/reviews/${reviewId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({ known: known })
      })

      if (response.ok) {
        const data = await response.json()
        if (known && this.shouldRemoveCard(data.next_review_date)) {
          currentCard.classList.add('hidden')
        }
        this.showNextCard()
      } else {
        console.error('Failed to update review')
      }
    } catch (error) {
      console.error('Error updating review:', error)
    }
  }

  shouldRemoveCard(nextReviewDate) {
    const tomorrow = new Date()
    tomorrow.setDate(tomorrow.getDate() + 1)
    tomorrow.setHours(0, 0, 0, 0)
    return new Date(nextReviewDate) >= tomorrow
  }

  showNextCard() {
    this.cardTargets[this.currentIndex].classList.add('hidden')
    this.currentIndex = (this.currentIndex + 1) % this.totalCards
    this.cardTargets[this.currentIndex].classList.remove('hidden')
    this.updateProgress()
  }

  updateProgress() {
    this.progressTarget.textContent = `Card ${this.currentIndex + 1} of ${this.totalCards}`
  }
}
