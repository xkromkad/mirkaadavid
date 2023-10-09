<template>
      <div class="nameText q-mb-md" :style="{ fontSize: fontSize + 'px' }">
        Svadobné dary
      </div>
      <div class="text text-center q-my-lg q-mb-xl">
        Berte toto oznámenie ako malú radu, <br />
        svadba nie je o trápení, čo dať k svadobnému daru. <br />
        <br />
        Ak nám niečím prispejete, budeme za to radi, <br />
        oveľa dôležitejšie však pre nás bude, ak strávite tento deň s nami.
      </div>
</template>

<script>
import { inject } from 'vue';
export default {
  name: 'WeddingGifts',
  setup() {
    const fontSize = inject('fontSize');
    return { fontSize };
  },
};
</script>
