import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="darkmode"
export default class extends Controller {
  static targets = ["footer", "navbar", "body"]

  connect() {
    console.log("darkmode_controller")
    console.log(this.footerTarget.classList)
    console.log(this.navbarTarget.classList)
  }
  toggle() {
    this.footerTarget.classList.toggle("darkmode");
    this.navbarTarget.classList.toggle("darkmode");
    this.bodyTarget.classList.toggle("darkmode");
  }
}
