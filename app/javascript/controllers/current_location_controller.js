import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="current-location"
export default class extends Controller {
 static targets = ['link']
  connect() {
    console.log("hello")
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        console.log(position.coords.latitude, position.coords.longitude);
        console.log(this.linkTarget.href);
        this.linkTarget.href = this.linkTarget.href + `?lat=${position.coords.latitude}&lng=${position.coords.longitude}`;
      });
    }
  }
}
