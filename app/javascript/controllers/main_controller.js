import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="main"
export default class extends Controller {
  // static targets = ["navBar"];

  connect() {}

  toggleNavbar() {
    const element = this.element;
    element.classList.toggle("expand");
  }
}
