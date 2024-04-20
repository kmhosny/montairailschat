import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'

export default class extends Controller {
  async sendMessage(event) {
    event.preventDefault()
    const message = document.getElementById("message").value
    const response = await post("/chat",{
      body: JSON.stringify({ message: message })
    })
    if (response.ok) {
      const body = await response.json
      document.getElementById("message").value = ""
      document.querySelector("[data-target='chat.messages']").insertAdjacentHTML("beforeend", "<br> U: "+message)
      document.querySelector("[data-target='chat.messages']").insertAdjacentHTML("beforeend", "<br> AI: "+body.response)
    }
  }
}
