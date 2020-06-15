<template>
  <div id="app">
    <h1> welcome, {{ formatName(user) }}! </h1>
  </div>
</template>

<script>
export default {
  name: 'app',
  data() {
    return {
      user: {
        firstName: 'Vue',
        lastName: 'App'
      }
    };
  },
  methods: {
    formatName(user) {
      return `${user.firstName} ${user.lastName}`;
    }
  }
}
</script>

<style lang="scss">
</style>
