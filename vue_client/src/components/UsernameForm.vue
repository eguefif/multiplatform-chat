<script setup>
import { ref } from 'vue'
import { userStore } from '@/stores/user'
import { useRouter } from 'vue-router'

const username = ref('')

const setUsername = userStore().setUsername

const router = useRouter()

function submitForm() {
  setUsername(username.value)
  console.log(`New username ${userStore().username}`)
  router.replace('/chat')
}
</script>

<template>
  <form @submit.prevent="submitForm">
    <label>Enter a username</label>
    <input v-model="username" />
    <button type="submit">Submit</button>
  </form>
</template>

<style scoped>
label {
  margin-right: 15px;
}
button {
  margin-left: 15px;
}
</style>
