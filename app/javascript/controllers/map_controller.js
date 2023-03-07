import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array
  }

  static targets = ["canvas", "alert"]

  connect() {
    console.log("mapcontroller")
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.canvasTarget,
      // style: "mapbox://styles/mapbox/streets-v10"
      style: "mapbox://styles/mapbox/streets-v12",
      center: [-24, 42], // starting center in [lng, lat]
      zoom: 1 // starting zoom
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    // this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    //   mapboxgl: mapboxgl }))
    // the original search bar
    this.map.addControl(
      new mapboxgl.GeolocateControl({
          positionOptions: {
              enableHighAccuracy: true
          },
          // When active the map will receive updates to the device's location as it changes.
          trackUserLocation: true,
          // Draw an arrow next to the location dot to indicate which direction the device is heading.
          showUserHeading: true
      })
    );
    this.direction = new MapboxDirections({
      accessToken: mapboxgl.accessToken
  }),
    navigator.geolocation.getCurrentPosition((position) => {
      console.log(position)
      const lat = position.coords.latitude
      const long = position.coords.longitude
      this.direction.setOrigin([long, lat])
    });
    this.map.addControl(
      this.direction,
      'top-left'
    );
  }

  toggle(event) {
    const style = this.map.style.stylesheet.id;
    console.log(style);
    if (style === "dark-v10") {
      this.map.setStyle("mapbox://styles/mapbox/streets-v10")
    } else {
      this.map.setStyle("mapbox://styles/mapbox/dark-v10")
    }
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.popup_window_html)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  showAlert(){
    this.alertTarget.classList.add("show");
    setTimeout(()=>{
      this.alertTarget.classList.remove("show");
    }, 4000)
  }

}
