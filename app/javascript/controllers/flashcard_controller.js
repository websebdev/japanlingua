import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "progress"]
  
  connect() {
    this.currentIndex = 0
    this.totalCards = this.cardTargets.length
    this.updateProgress()
  }
  
  flipCard(event) {
    const card = event.currentTarget
    card.classList.toggle("flipped")
  }
  
  markKnown() {
    this.nextCard(true)
  }
  
  markUnknown() {
    this.nextCard(false)
  }
  
  nextCard(known) {
    // Here you would typically send an AJAX request to update the SRS system
    this.currentIndex++
    
    if (this.currentIndex < this.totalCards) {
      this.cardTargets[this.currentIndex - 1].classList.add("hidden")
      this.cardTargets[this.currentIndex].classList.remove("hidden")
      
      // Reset the card to its front side
      const currentCard = this.cardTargets[this.currentIndex].querySelector('.flashcard')
      currentCard.classList.remove("flipped")
      
      this.updateProgress()
    } else {
      this.showCompletionMessage()
    }
  }
  
  updateProgress() {
    this.progressTarget.textContent = `Card ${this.currentIndex + 1} of ${this.totalCards}`
  }
  
  showCompletionMessage() {
    // ... (same as before) ...
  }
  
  restart() {
    window.location.reload()
  }
}
