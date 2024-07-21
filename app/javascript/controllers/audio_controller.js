import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["playButton", "stopButton", "sentence"]

  connect() {
    this.audioPlayers = []
  }

  async playAll(event) {
    this.stopAllAudio()
    for (let i = 0; i < this.playButtonTargets.length; i++) {
      const button = this.playButtonTargets[i]
      await this.playSentence({ currentTarget: button })
    }
  }

  async playSentence(event) {
    this.stopAllAudio()
    const button = event.currentTarget
    this.togglePlayStopButtons(button)
    await this.playAudio(button.dataset.audioUrlParam)
    this.hideAllStopButtons()
  }

  playAudio(url) {
    return new Promise((resolve) => {
      const audio = new Audio(url)
      audio.play()
      this.audioPlayers.push(audio)
      audio.addEventListener("ended", () => {
        resolve()
      })
    })
  }

  stopAllAudio() {
    this.audioPlayers.forEach((audio) => audio.pause())
    this.audioPlayers = []
    this.hideAllStopButtons()
  }

  togglePlayStopButtons(button) {
    const playButton = button.parentElement.querySelector("[data-audio-target='playButton']")
    const stopButton = button.parentElement.querySelector("[data-audio-target='stopButton']")
  
    if (playButton && stopButton) {
      playButton.classList.toggle("hidden")
      stopButton.classList.toggle("hidden")
    }
  }

  hideAllStopButtons() {
    this.stopButtonTargets.forEach((stopButton) => stopButton.classList.add("hidden"))
    this.playButtonTargets.forEach((playButton) => playButton.classList.remove("hidden"))
  }
}
