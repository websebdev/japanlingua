import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "progress", "container", "completionMessage"]

  connect() {
    this.currentIndex = 0
    this.totalCards = this.cardTargets.length
    this.reviewedCards = 0
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
        this.reviewedCards++
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
    if (this.reviewedCards >= this.totalCards) {
      this.showCompletionMessage()
    } else {
      this.cardTargets[this.currentIndex].classList.add('hidden')
      this.currentIndex = (this.currentIndex + 1) % this.totalCards
      this.cardTargets[this.currentIndex].classList.remove('hidden')
      this.updateProgress()
    }
  }

  updateProgress() {
    this.progressTarget.textContent = `Card ${this.currentIndex + 1} of ${this.totalCards}`
  }

  showCompletionMessage() {
    this.containerTarget.classList.add('hidden')
    this.completionMessageTarget.classList.remove('hidden')
  }
}
