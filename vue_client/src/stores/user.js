import { ref } from 'vue'
import { defineStore } from 'pinia'

export const userStore = defineStore('user', () => {
  const username = ref('')
  function setUsername(value) {
    username.value = value
  }
  return { username, setUsername }
})
