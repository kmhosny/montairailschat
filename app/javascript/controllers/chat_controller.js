import { Turbo } from "@hotwired/turbo-rails"
import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
window.Turbo = Turbo
export default class extends Controller {
  async sendMessage(event) {
    event.preventDefault()
    document.getElementById("loading").removeAttribute("hidden")
    const message = document.getElementById("message").value
    const response = await post("/chat",{
      body: JSON.stringify({ message: message }),
      responseKind: "turbo-stream"

    })
    if (response.ok) {
      document.getElementById("message").value = ""
      document.getElementById("loading").setAttribute("hidden", true)
      const messages = document.querySelectorAll("[data-message-selector]");
      messages.scrollTop = messages[message.length-1].scrollHeight;
    }
  }
}
