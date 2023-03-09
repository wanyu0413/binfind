import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {

  static values = {
    apiKey: String,
    markers: Array,
    coord: Array
  }

  static targets = ["canvas", "alert"]

  connect() {
    console.log("mapcontroller")
    // console.log(window.location.href);
    // if (this.coordValue.length > 0) console.log(this.coordValue);

    const url = new URLSearchParams(window.location.search)

    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.canvasTarget,
      // style: "mapbox://styles/mapbox/streets-v10"
      style: "mapbox://styles/mapbox/streets-v12",
      center: [-24, 42], // starting center in [lng, lat]
      zoom: 0.1 // starting zoom
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
      const lat = position.coords.latitude
      const long = position.coords.longitude
    });

    this.map.addControl(
      this.direction,
      'top-left'
    );

    this.direction.on("destination", (e) => {
      // console.log(e.feature.geometry.coordinates)
      const originCoords = this.direction.getOrigin().geometry.coordinates
      const destinationCoords = this.direction.getDestination().geometry.coordinates
      this.map.fitBounds([originCoords, destinationCoords], { padding: 70, maxZoom: 15, duration: 0 })

    })
    document.addEventListener("turbolinks:load", () => {
      const url = new URLSearchParams(window.location.search)

      if(url.get("lat") && url.get('lng')) {
        console.log('fly');
        this.map.flyTo({
          center: [url.get('lng'), url.get("lat")],
          zoom: 22,
          essential: true,
        })
      }
    }
    );
    if(url.get("lat") && url.get('lng')) {
      console.log('fly');
      this.map.flyTo({
        center: [url.get('lng'), url.get("lat")],
        zoom: 22,
        essential: true,
      })
    }
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
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html
      new mapboxgl.Marker(customMarker)
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
