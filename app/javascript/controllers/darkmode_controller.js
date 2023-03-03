import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="darkmode"
export default class extends Controller {
  static targets = ["footer", "navbar", "map"]

  connect() { console.log("connected")
  }
  // toggle() {
  //   this.footerTarget.classList.toggle("darkmode");
  //   this.navbarTarget.classList.toggle("darkmode");
  // }
}
