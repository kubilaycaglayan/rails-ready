import consumer from "channels/consumer"

consumer.subscriptions.create("MonitorUserStatusChannel", {
  rejected() {
    console.log("rejected from monitoring")
  },

  connected() {
    console.log("connected to monitoring")
  },

  disconnected() {
    console.log("disconnected from monitoring")
  },

  received(data) {
    this.updateUsersStatuses(data.statuses)
  },

  updateUsersStatuses(userStatuses) {
    userStatuses.forEach(({ user_id, status }) => {
      this.updateStatusElement(user_id, `${status}`)
    })
  },

  updateStatusElement(userId, status) {
    const element = document.querySelector(`#monitor-status-${userId}`)

    if (element) {
      element.textContent = status
    }
  }
});
