import { Turbo } from "@hotwired/turbo-rails"
import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
window.Turbo = Turbo
export default class extends Controller {
  async sendMessage(event) {
    event.preventDefault()
    document.getElementById("loading").removeAttribute("hidden")
    const no_chat = document.getElementById("no_chat_history")
    if (no_chat) {
      no_chat.setAttribute("hidden", true)
    }
    const message = document.getElementById("message").value
    const response = await post("/chat",{
      body: JSON.stringify({ message: message }),
      responseKind: "turbo-stream"

    })
    if (response.ok) {
      document.getElementById("message").value = ""
      document.getElementById("loading").setAttribute("hidden", true)
    }
  }
}
