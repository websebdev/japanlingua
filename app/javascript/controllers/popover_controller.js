import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["popover"];

  connect() {
    this.hidePopovers();
    console.log("popover controller connected");
    document.addEventListener("click", this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this));
  }

  togglePopover(event) {
    event.stopPropagation();
    this.hidePopovers();
    const popoverId = event.params.content;
    const popoverElement = this.getPopoverTarget(popoverId);
    const wordElement = event.currentTarget;
    if (popoverElement) {
      this.positionPopover(wordElement, popoverElement);
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

  positionPopover(wordElement, popoverElement) {
    const rect = wordElement.getBoundingClientRect();
    const popoverRect = popoverElement.getBoundingClientRect();
    const top = rect.top + window.scrollY + rect.height;
    const left = rect.left + window.scrollX - (popoverRect.width / 2) + (rect.width / 2);

    popoverElement.style.top = `${top}px`;
    popoverElement.style.left = `${left}px`;
  }

  handleClickOutside(event) {
    const isClickInsidePopover = this.popoverTargets.some((popover) => popover.contains(event.target));
    if (!isClickInsidePopover) {
      this.hidePopovers();
    }
  }
}
