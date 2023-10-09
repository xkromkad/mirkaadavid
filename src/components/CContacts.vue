<template>
  <div class="nameText q-mb-md" :style="{ fontSize: fontSize + 'px' }">
    Kontakt
  </div>
  <div class="text text-center q-my-lg q-mb-xl">
    Ak sa potrebujete niečo opýtať, volajte alebo píšte. <br />
  </div>
  <div class="row text-center justify-center">
    <div class="text text-center q-px-md q-my-lg q-mb-xl col-md-12 col-lg-6">
      Mirka <br />
      <a href="tel:+421950376456">+421 950 376 456</a> <br />
      <a href="https://m.me/miriam.krisandova" target="_blank">Messenger</a>
    </div>
    <div class="text text-center q-px-md q-my-lg q-mb-xl col-md-12 col-lg-6">
      Dávid <br />
      <a href="tel:+421904679773">+421 904 679 773</a> <br />
      <a href="https://m.me/david.kromka.7" target="_blank">Messenger</a>
    </div>
  </div>
</template>

<script lang="ts">
import { inject } from 'vue';
export default {
  name: 'CContacts',
  setup() {
    const fontSize = inject('fontSize');
    return { fontSize };
  },
};
</script>
