<template>
  <q-layout view="lHh Lpr lFf" id="layout">
    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'MainLayout',

  setup() {
    return {};
  },
});
</script>

<style>
#layout {
  max-width: 110rem;
  margin: 0 auto; /* This centers the element horizontally */
}
</style>
