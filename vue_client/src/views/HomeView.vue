<script setup>
import { userStore } from '@/stores/user'
import UsernameForm from '@/components/UsernameForm.vue'
const username = userStore().username
const isUsername = username.length > 0 ? true : false
console.log(username)
</script>

<template>
  <div v-if="isUsername">Hello</div>
  <UsernameForm v-if="!isUsername" />
</template>
