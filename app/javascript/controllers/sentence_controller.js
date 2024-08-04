
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggleText({ target, params: { targetId }}) {
    let textTarget = document.getElementById(targetId);
    if (textTarget.classList.contains("hidden")) {
      target.textContent = "HIDE TEXT"
      document.getElementById(targetId).classList.remove("hidden")
    } else {
      target.textContent = "SHOW TEXT"
      document.getElementById(targetId).classList.add("hidden")
    }
  }
}
