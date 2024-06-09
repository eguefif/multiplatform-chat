<script setup>
import { userStore } from '@/stores/user'
import { onMounted, ref } from 'vue'

var userList = ref([])
const username = userStore().username

onMounted(() => {
  const websocket = new WebSocket('ws://localhost:3001')
  websocket.onopen = () => {
    console.log('Websocket connection opened')
    if (username.length > 0) websocket.send(JSON.stringify({ username: userStore().username }))
    else websocket.send(JSON.stringify({ username: 'Emmanuel' }))
  }
  websocket.onmessage = (event) => {
    console.log(`New message: ${event.data}`)
    processMessage(event.data)
  }
})

function processMessage(data) {
  const message = JSON.parse(data)
  console.log(username)
  if (message.command == 'clientlist') {
    userList.value = message.content.filter((user) => user !== username)
  }
}
</script>
<template>
  <h1>List of connected user</h1>
  <ul>
    <li v-for="user in userList" :key="user">{{ user }}</li>
  </ul>
</template>
