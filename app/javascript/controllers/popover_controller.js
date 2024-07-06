import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["popover"];

  connect() {
    this.hidePopovers();
    console.log("popover controller connected");
  }

  togglePopover(event) {
    this.hidePopovers();
    const popoverId = event.params.content
    const popoverElement = this.getPopoverTarget(popoverId);
    if (popoverElement) {
      popoverElement.classList.toggle("invisible");
      popoverElement.classList.toggle("opacity-0");
    }
  }

  hidePopovers() {
    this.popoverTargets.forEach((popover) => {
      popover.classList.add("invisible");
      popover.classList.add("opacity-0");
    });
  }

  getPopoverTarget(id) {
    return this.popoverTargets.find((popover) => popover.id === id);
  }
}
