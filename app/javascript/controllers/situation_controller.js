import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sentenceCard", "textToggle", "textContent", "nextButton"]
  static values = {
    currentIndex: Number,
    totalSentences: Number
  }

  connect() {
    this.showCurrentSentence()
  }

  showCurrentSentence() {
    this.sentenceCardTargets.forEach((card, index) => {
      card.classList.toggle("hidden", index !== this.currentIndexValue)
    })
    this.resetView()
  }

  resetView() {
    this.textContentTargets[this.currentIndexValue].classList.add("hidden")
    this.textToggleTarget.textContent = "Show text"
    this.textToggleTarget.classList.remove("hidden")
    this.nextButtonTarget.classList.add("hidden")
  }

  toggleText(event) {
    event.preventDefault()
    this.textContentTargets[this.currentIndexValue].classList.toggle("hidden")
    this.updateToggleButton()
  }

  updateToggleButton() {
    const isTextVisible = !this.textContentTargets[this.currentIndexValue].classList.contains("hidden")
    if (isTextVisible) {
      this.textToggleTarget.classList.add("hidden")
      this.nextButtonTarget.classList.remove("hidden")
    } else {
      this.textToggleTarget.classList.remove("hidden")
      this.nextButtonTarget.classList.add("hidden")
    }
  }

  next(event) {
    event.preventDefault()
    if (this.currentIndexValue < this.totalSentencesValue - 1) {
      this.currentIndexValue++
      this.showCurrentSentence()
    } else {
      // Navigate to the all sentences view
      window.location.href = event.currentTarget.getAttribute("data-all-sentences-url")
    }
  }
}
