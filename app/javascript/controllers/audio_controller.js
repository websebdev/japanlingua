import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  playAll(event) {
    this.playAudio(this.audioUrls);
  }

  playSentence(event) {
    this.playAudio([event.params.url]);
  }

  get audioUrls() {
    return this.element.querySelectorAll("[data-audio-url-param]").map((btn) =>
      btn.dataset.audioUrlParam
    );
  }

  playAudio(urls) {
    urls.forEach((url) => {
      const audio = new Audio(url);
      audio.play();
    });
  }
}
