import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "converted", "input" ]

  connect() {
    console.log("Hello, Stimulus!", this.element)
  }

  convert() {
    console.log("Converting")
    console.log(this.inputTarget.value)
    this.convertedTarget.textContent = this.inputTarget.value * 2
  }
}
